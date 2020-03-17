$(document).on('turbolinks:load', function() {
  function buildImage(loadedImageUri){
    var html =
    `<li class="item-image-container__unit--preview" id="visible">
      <div class="item-image-container__unit--caption">
        <img src="${loadedImageUri}">
      </div>
      <div class="image-option">
        <div  class="image-option__list">
          <div class="image-option__list--tag">編集</div>
        </div>
        <div class="image-option__list">
          <a class="image-option__list--tag">削除</a>
        </div>
      </div>
    </li>`
    return html
  };

  var files_array = [];

  $('.item-image-container__unit--guide').on('dragover',function(e){
      e.preventDefault();
  });

  $('.item-image-container__unit--guide').on('drop',function(event){
    event.preventDefault();
      
    files = event.originalEvent.dataTransfer.files;
      
    var count = files.length;

    if(count<=5){
      for (var i=0; i<count; i++) {
        files_array.push(files[i]);
        var fileReader = new FileReader();
        
        fileReader.onload = function( event ) {
        
        var loadedImageUri = event.target.result;
        
        $(buildImage(loadedImageUri,)).appendTo(".item-image-container__unit ul").trigger("build");
        };

        fileReader.readAsDataURL(files[i]);

      }
    }

    var elm = document.getElementById('d-d-delete');
    elm.style.display = 'none';

    var cl = document.getElementById('click-delete');
    cl.style.display = 'none';
    
  });

  $(document).on('click','.item-image-container__unit--preview a',function(){

    var index = $(".item-image-container__unit--preview a").index(this);

    files_array.splice(index - 1, 1);

    $(this).parent().parent().parent().remove();
  });

  //ここからカテゴリの段階的表示機能
  function buildHTML(result){
    var html =
      `<option value= ${result.id}>${result.name}</option>`
    return html
  }

  $("#parent").on("change",function(){
    var str = document.getElementById("parent").value
    if(str == 0){
      $('#child').remove();
      $('#item_category_id').remove();
      $('.items-new-second__head--fourth').css('display','none');
      $("#item_product_size_id").remove();
    }else{
      $.ajax({
        url: "/categories",
        type: 'GET',
        dataType: 'json',
        data: {id: str}
      })
      .done(function(categories) {
        var insertHTML = `<select name="child" id="child">
                          <option value=0>---</option>`;
        $.each(categories, function(i, category) {
          insertHTML += buildHTML(category)
        });
        insertHTML += `</select>`
        if($('#child').length){
          $('#child').replaceWith(insertHTML);
          $('#item_category_id').remove();
          $('#item_product_size_id').remove();
          $('.items-new-second__head--fourth').css('display','block');
        } else {
          $('.items-new-second__head--second').append(insertHTML);
        };
      })
      .fail(function() {
        alert("サーバとの通信に失敗しました");
      });
    };
  })

  $(document).on("change","#child",function(){
    var strparent = document.getElementById("parent").value
    var strchild = document.getElementById("child").value
    var str = strparent + '/' + strchild
    if(strchild == 0){
      $('#item_category_id').remove();
      $('.items-new-second__head--fourth').css('display','none');
      $("#item_product_size_id").remove();
    } else {
      $.ajax({
        url: "/categories",
        type: 'GET',
        dataType: 'json',
        data: {id: str}
      })
      .done(function(categories) {
        var insertHTML = `<select name="item[category_id]" id="item_category_id">
                          <option value=0>---</option>`;
        $.each(categories, function(i, category) {
          insertHTML += buildHTML(category)
        });
        insertHTML += `</select>`
        if($('#item_category_id').length){
          $('#item_category_id').replaceWith(insertHTML);
          $('#item_product_size_id').remove();
          $('.items-new-second__head--fourth').css('display','none');
        } else {
          $('.items-new-second__head--third').append(insertHTML);
        };
      })
      .fail(function() {
        alert("サーバとの通信に失敗しました");
      });
    };
  })

  $(document).on("change","#item_category_id",function(){
    var str = document.getElementById("item_category_id").value
    if(str == 0){
      $('.items-new-second__head--fourth').css('display','none');
      $("#item_product_size_id").remove();
    } else {
      $.ajax({
        url: "/product_sizes",
        type: 'GET',
        dataType: 'json',
        data: {id: str}
      })
      .done(function(product_sizes) {
        var insertHTML = `<select name="item[product_size_id]" id="item_product_size_id">`;
        $.each(product_sizes, function(i, product_size) {
          insertHTML += buildHTML(product_size)
        });
        insertHTML += `</select>`
        if($('#item_product_size_id').length){
          $('#item_product_size_id').replaceWith(insertHTML);
        } else {
          $('.items-new-second__head--fourth').css('display','block');
          $('.items-new-second__head--fourth').append(insertHTML);
        }
      })
      .fail(function() {
        alert("サーバとの通信に失敗しました");
      });
    };
  })

  //ここから配送方法の段階的表示機能
  $("#shippingway").on("change",function(){
    var str = document.getElementById("shippingway").value
    if(str == 1){
      $('#item_shippingway_id').remove();
      $(".items-new-third__center").css('display','none');
    }else{
      $.ajax({
        url: "/shippingways",
        type: 'GET',
        dataType: 'json',
        data: {id: str}
      })
      .done(function(shippingways) {
          var insertHTML = ` <select name="item[shippingway_id]" id="item_shippingway_id">`;
        $.each(shippingways, function(i, shippingway) {
          insertHTML += buildHTML(shippingway)
        });
        insertHTML += `</select>`
        if($('#item_shippingway_id').length){
          $('#item_shippingway_id').replaceWith(insertHTML);
        } else {
          $(".items-new-third__center").css('display','block');
          $('.items-new-third__center').append(insertHTML);
        };
      })
      .fail(function() {
        alert("サーバとの通信に失敗しました");
      });
    }
  });

//次の画像機能の実装で使用する予定のためコメントアウトしています。
// function buildhtml(result){
// <select name="child" id="child">
//   <option value="1">レディース</option>
//   <option value="15">メンズ</option>
// </select>
// }
// var aj_url = window.location.pathname;
// var aj_url = '/users/1/items';

// $('#new_item').on('submit', function(e){
//   e.preventDefault();
  
//   var formData = new FormData($(this).get(0));
  
//   files_array.forEach(function(file){
//    formData.append("image[images][]" , file)
//   });
  
//   $.ajax({
//     url:         aj_url,
//     type:        "POST",
//     data:        formData,
//     contentType: false,
//     processData: false,
//     dataType:   'json',
//   })
//   .done(function(){
//     alert('出品に成功しました！');
//   })
//   .fail(function(){
//     alert('出品に失敗しました！');
//   });
// });
})