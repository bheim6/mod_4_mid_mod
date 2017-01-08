var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $newLinkTitle = $("#link_title");
  $newLinkUrl  = $("#link_url");

  $("#submit_link").on('click', createLink);
})

function createLink (event){
  event.preventDefault();

  console.log("win")

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .then( attachReadEvents )
   .fail( displayFailure )
 }

function getLinkData() {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink(link){
  $("#links_list").prepend( linkHTML(link) )
  clearLink();
}

function linkHTML(link) {

  var markAs;
  var read = link.read;
  if (read === "true") {
    markAs = "Mark as Unread"
  } else {
    markAs = "Mark as Read"
  };

    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              Title:
              <p class='link-title' contenteditable=true>${ link.title }</p>
              Url:
              <div class="link_buttons">
              <a href="${link.url}" target="_blank">${link.url}</a>
              <p class="mark-as">${ markAs }</p>
                <button class="read-button">*</button>
                Read? -
                <span class="link_read">${ link.read }</span>
                <button class='delete-link'>Delete</button>
              </div>
            </div>`
}

function clearLink() {
  $newLinkTitle.val("");
  $newLinkUrl.val("");
}

function displayFailure(failureData){
  console.log("FAILED attempt to create new Link: " + failureData.responseText);
  // $('#links_list').prepend("FAILED attempt to create new Link: " + failureData.responseText + "<br>");
}


function attachReadEvents(link) {
  $(".read-button").on("click", readChange)
}

function readChange(link) {
  var id = $(this).closest(".link").data('id');
  var parent = $(this).closest(".link");
  var title = $(parent).find('.link-title').text();
  var url = $(this).siblings("a").text();

  var read = $(this).siblings("span").text();
  if (read === "false") {read = "true"}
  else if (read === "true") {read = "false"}

  var markAs = $(this).siblings("p").text();
  if (markAs === "Mark as Read") {markAs = "Mark as Unread"}
  else if (markAs === "Mark as Unread") {markAs = "Mark as Read"}
  // debugger

  $(this).siblings("span").text(read);
  $(this).siblings("p").text(markAs);
  if (read === "true") {
    $(this).siblings("a").css("text-decoration","line-through");
  } else {
    $(this).siblings("a").css("text-decoration","none");
  }

  updateRead(read, id, title, url);
}

function updateRead(read, id, title, url) {
  $.ajax({
    url: `/api/v1/links/${id}`,
    method: 'put',
    data: {link: {read: read}}
  })

  if (read === "true") {
    console.log("reading true")
    $.post({
      url: 'http://localhost:3001/add_read',
      data: {
        title: title,
        url: url
      },
      dataType: 'jsonp'
    })
  }
}
