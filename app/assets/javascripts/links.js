$(document).ready(function() {
  renderAllLinks();
});

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
    var newLink = $('<div class="idea" data-id="' + link.id + '">' +
                      '<h2 id="title-' + link.id + '">' + link.title + '</h2>' +
                      '<a id="url-' + link.id + '">' + link.url + '</a>' +
                      '<p class="status"><b>Read:</b><p id="status"> ' + getStatus(link) + '</p></p>' +
                      '<div class="change-status">' +
                        '<button id="mark-as-read-' + link.id + '" class="' + read(link) + '">Mark as read</button>' +
                        '<button id="mark-as-unread-' + link.id + '" class="' + unread(link) + '">Mark as unread</button>' +
                      '</div></p>' +
                    '</div>');

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

