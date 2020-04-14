$(document).on('turbolinks:load', function() {

  $(".categories").hover(
    function(){
      $(".category-tree").fadeIn()
    },
    function(){
      $(".category-tree").fadeOut()
      $('.category-tree__child').fadeOut();
      $('.category-tree__grand-child').fadeOut();
      $('.category-tree__child--list').remove();
      $('.category-tree__grand-child--list').remove();
    }
  )

  $(".brands").hover(
    function(){
      $(".brand-tree").fadeIn()
    },
    function(){
      $(".brand-tree").fadeOut()
    }
  )

  function buildChildHTML(int,category){
    var id = int + "/" + category.id
    var html = `
                <li class="category-tree__child--list" data-category-id=${id}>
                  <a href="/categories/${category.id}">${category.name}</a>
                </li>
              `
    return html
  }
  function buildGrandChildHTML(int,category){
    var id = int + "/" + category.id
    var html = `
                <li class="category-tree__grand-child--list" data-category-id=${id}>
                  <a href="/categories/${category.id}">${category.name}</a>
                </li>
              `
    return html
  }

  $(".category-tree__parent--list").on('mouseover',function(){
    if ($(".category-tree__grand-child--list").length){
      $('.category-tree__grand-child--list').remove()
      $('.category-tree__grand-child').fadeIn()}
      var int = $(this).attr("data-category-id")
      $.ajax({
        url: "/api/categories",
        type: 'GET',
        dataType: 'json',
        data: {id: int}
      })
      .done(function(categories) {
        var insertHTML = ``
        $.each(categories, function(i,category) {
          insertHTML += buildChildHTML(int,category)
        });
        if ($(".category-tree__child--list").length){
          $('.category-tree__child--list').remove();
          $('.category-tree__child').append(insertHTML)
        }else{
          $('.category-tree__child').append(insertHTML)
          $('.category-tree__child').fadeIn()
        }
      })
      .fail(function(){
        alert("サーバとの通信に失敗しました");
      });
  });
  $(document).on('mouseover',".category-tree__child--list",function(){
    var int = $(this).attr("data-category-id")
    $.ajax({
      url: "/api/categories",
      type: 'GET',
      dataType: 'json',
      data: {id: int}
    })
    .done(function(categories) {
      var insertHTML = ``
      $.each(categories, function(i, category) {
        insertHTML += buildGrandChildHTML(int,category)
      });
      if ($(".category-tree__grand-child--list").length){
        $('.category-tree__grand-child--list').remove();
        $('.category-tree__grand-child').append(insertHTML)
      }else{
        $('.category-tree__grand-child').append(insertHTML)
        $('.category-tree__grand-child').fadeIn()
      }
    })
    .fail(function(){
      alert("サーバとの通信に失敗しました");
    });
  });
})