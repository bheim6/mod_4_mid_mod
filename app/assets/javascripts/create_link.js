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
  // clearLink();
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
              <p class='link-title' contenteditable=true>Title: ${ link.title }</p>
              <p class='link-url' contenteditable=true>Url: ${ link.url }</p>
              <div class="link_buttons">
              <p class="mark-as">${ markAs }</p>
              Read? -
              <span class="link_read">${ link.read }</span>
                <button class="read-true">+</button>
                <button class="read-false">-</button>
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
}


function attachReadEvents() {
  $(".read-true").on("click", readTrue)
  $(".read-false").on("click", readFalse)
}

function readTrue() {
  var id = $(this).closest(".link").data('id');

  var read = $(this).siblings("span").text();
  if (read === "false") {read = "true"}

  var markAs = $(this).siblings("p").text();
  if (markAs === "Mark as Read") {markAs = "Mark as Unread"}

  $(this).siblings("span").text(read);
  $(this).siblings("p").text(markAs);

  updateRead(read, id);
}

function readFalse() {
  var id = $(this).closest(".link").data('id');

  var read = $(this).siblings("span").text();
  if (read === "true") {read = "false"}

  $(this).siblings("span").text(read);

  updateRead(read, id);
}

function updateRead(read, id) {
  $.ajax({
    url: `/api/v1/links/${id}`,
    method: 'put',
    data: {link: {read: read}}
  })
}
