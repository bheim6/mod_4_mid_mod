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

    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title' contenteditable=true>Title: ${ link.title }</p>
              <p class='link-url' contenteditable=true>Url: ${ link.url }</p>

              <p class="link_read">
                Read? ${ link.read }
              </p>
              <p class="link_buttons">
                <button class="read-true">+</button>
                <button class="read-false">-</button>
                <button class='delete-link'>Delete</button>
              </p>
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
  console.log("chyea");
  var id = $(this).closest(".link").data('id');

  var quality = $(this).siblings("span").text();
  if (quality === "swill") {quality = "plausible"}
  else if (quality === "plausible") {quality = "genius"}

  $(this).siblings("span").text(quality);

  updateRead(quality, id);
}

function readFalse() {
  var id = $(this).closest(".link").data('id');

  var quality = $(this).siblings("span").text();
  if (quality === "genius") {quality = "plausible"}
  else if (quality === "plausible") {quality = "swill"}

  $(this).siblings("span").text(quality);

  updateRead(quality, id);
}

function updateRead(read, id) {
  $.ajax({
    url: `/api/v1/links/${id}`,
    method: 'put',
    data: {link: {read: read}}
  })
}
