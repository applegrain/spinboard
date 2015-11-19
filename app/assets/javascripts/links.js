$(document).ready(function() {
  renderAllLinks();
  filterByInput();
  filterByRead();
  filterByUnread();
  sortAlphabetically();
});

function filterByInput() {
  $('.search-by').on('click', function() {
    $('.link').each(function() {
      var searchTerm = $('.search-field').val();
      var title = $(this).find('#title-' + $(this).data('id')).text();
      var url   = $(this).find('#url-' + $(this).data('id')).text();

      var content = title + url;
      var match = content.indexOf(searchTerm) !== -1;
      $(this).toggle(match);
    });
  });
}

function filterByRead() {
  $('.filter-by-read').on('click', function() {
    $('.link').each(function() {
      var status = $(this).find('#status').text().trim();

      if (status != 'read') { $(this).toggleClass('hidden') }
    });
  });
}

function filterByUnread() {
  $('.filter-by-unread').on('click', function() {
    $('.link').each(function() {
      var status = $(this).find('#status').text().trim();

      if (status != 'unread') { $(this).toggleClass('hidden') }
    });
  });
}

function sortAlphabetically() {
  $('.filter-alphabetically').on('click', function() {
    var children = $('.all-links').children().detach();

    children.sort(function(a, b) {
      if ($(a).find("h2").text().toLowerCase() > $(b).find("h2").text().toLowerCase()) return 1;
      if ($(a).find("h2").text().toLowerCase() < $(b).find("h2").text().toLowerCase()) return -1;
      return 0;
    });

    $(".all-links").append(children);
  });
}

function renderAllLinks() {
  $.ajax({
    url: 'api/v1/links.json',
    type: 'GET',
    datatype: 'json',
    success: function(response) {
      mountLinksOnDom(response)
    }
  });
}

function mountLinksOnDom(links) {
  links.forEach(function(link) {
    var newLink = $('<div class="link" data-id="' + link.id + '">' +
                      '<h2 id="title-' + link.id + '">' + link.title + '</h2>' +
                      '<a id="url-' + link.id + '">' + link.url + '</a>' +
                      '<p class="status"><b>Read:</b><p id="status"> ' + getStatus(link) + '</p></p>' +
                      '<div class="change-status">' +
                        '<button id="mark-as-read-' + link.id + '" class="' + read(link) + '">Mark as read</button>' +
                        '<button id="mark-as-unread-' + link.id + '" class="' + unread(link) + '">Mark as unread</button>' +
                      '</div></p>' +
                    '<button class="edit-link-' + link.id + '">Edit</button>' +
                    '<div class="row" style="display: none;" id="edit-form-' + link.id + '">' +
                      '<div>' +
                        '<label>Title</label>' +
                          '<input type="text" id="link-title-' + link.id + '" value="' + link.title + '">' +
                        '<label>URL</label>' +
                        '<input type="textfield" id="link-url-' + link.id + '" value="' + link.url + '">' +
                      '</div>' +
                      '<input id="submit-link-' + link.id + '" type="button" name="submit" value="Create Link">' +
                    '</div>');

    onClickEditIdea(newLink);
    onClickSubmitIdea(newLink);
    onClickMarkAsRead(newLink);
    onClickMarkAsUnread(newLink);
    $('.all-links').append(newLink);
  });
}

function read(link) {
  return link.status ? "hidden" : "";
}

function unread(link) {
  return link.status ? "" : "hidden";
}

function getStatus(link) {
  return link.status ? "read" : "unread"
}

function onClickEditIdea(link) {
  link.find('.edit-link-' + link.data('id')).on('click', function() {
    link.find('#edit-form-' + link.data('id')).toggle('fast');
  });
}

function onClickSubmitIdea(link) {
  link.find('#submit-link-' + link.data('id')).on('click', function() {
    var title = link.find('#link-title-' + link.data('id')).val();
    var url   = link.find('#link-url-' + link.data('id')).val();

    updateLink(link, title, url);
  });
}

function updateLink(link, title, url) {
  $.ajax({
    url: 'api/v1/links/' + link.data('id') + '/edit.json',
    dataType: 'json',
    data: { link: { title: title, url: url } },
    type: 'GET',
    success: function(response) {
      link.find('#title-' + link.data('id')).text(title);
    }
  });
}
function onClickMarkAsRead(link) {
  link.find('#mark-as-read-' + link.data('id')).on('click', function() {
    markLinkAsRead(link, true);
    link.find('#mark-as-unread-' + link.data('id')).removeClass('hidden');
    link.find('#mark-as-read-' + link.data('id')).addClass('hidden');
  });
}

function markLinkAsRead(link, status) {
  $.ajax({
    url: 'api/v1/links/' + link.data('id') + '.json',
    dataType: 'json',
    data: { link: { status: status } },
    type: 'PUT',
    success: function(response) {
      link.find('#status').text('read');
    }
  });
}

function onClickMarkAsUnread(link) {
  link.find('#mark-as-unread-' + link.data('id')).on('click', function() {
    markLinkAsUnread(link, false);
    link.find('#mark-as-read-' + link.data('id')).removeClass('hidden');
    link.find('#mark-as-unread-' + link.data('id')).addClass('hidden');
  });
}

function markLinkAsUnread(link, status) {
  $.ajax({
    url: 'api/v1/links/' + link.data('id') + '.json',
    dataType: 'json',
    data: { link: { status: status } },
    type: 'PUT',
    success: function() {
      link.find('#status').text('unread');
      link.find('#mark-as-unread').addClass('hidden');
      link.find('#mark-as-read').removeClass('hidden');
    }
  });
}

