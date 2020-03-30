$(document).on('turbolinks:load', function() {
  // items/n/editの時の処理
  if (window.location.href.match(/\/items\/\d+\/edit/)){
    function buildImage(loadedImageUri,i){
      var html =
        `<li class="item-image-container__unit--preview" image-data-id=${i}>
          <div class="item-image-container__unit--caption">
            <img src="${loadedImageUri}">
          </div>
          <div class="image-option">
            <div  class="image-option__list">
              <div class="image-option__list--edit">編集</div>
            </div>
            <div class="image-option__list">
              <div class="image-option__list--delete">削除</div>
            </div>
          </div>
        </li>`
      return html
    };
    console.log('success1')
    if (typeof gon != "undefined") {
      if(gon.item_images){
        var files = gon.item_images
        var html = ``;
        html += gon_image(files)
        $(".item-image-container__unit ul").append(html).trigger("build");
      };
    };
  
    function gon_image(files){
      var insertHTML = '';
      $.each(files, function(i, file) {
        insertHTML += buildImage(file.image.url,i)
      });
      return insertHTML
    }
    // //登録済み画像のプレビュー表示欄の要素を取得する
    // var prevContent = $('.label-content').prev();
    // labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
    // $('.label-content').css('width', labelWidth);
    // var count = $('.preview-box').length;
    // //プレビューが5あるときは、投稿ボックスを消しておく
    // if (count == 5) {
    //   $('.label-content').hide();
    // }

  //=============================================================================

  // ラベルのwidth操作
  // function setLabel() {
  //   //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
  //   var prevContent = $('.label-content').prev();
  //   labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
  //   $('.label-content').css('width', labelWidth);
  // }

  // プレビューの追加
  $(document).on('change', '.hidden-field', function() {
    // setLabel();
    //hidden-fieldのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //labelボックスのidとforを更新
    $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
    //選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${id}`).length == 0) {
        var count = $('.preview-box').length;
        var html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        var prevContent = $('.label-content').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.preview-box').length;
      //プレビューが5個あったらラベルを隠す 
      if (count == 5) { 
        $('.label-content').hide();
      }

      //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す=============
      if ($(`#item_images_attributes_${id}__destroy`)){
        $(`#item_images_attributes_${id}__destroy`).prop('checked',false);
      } 
      //=============================================================================

      //ラベルのwidth操作
      // setLabel();
      //ラベルのidとforの値を変更
      if(count < 5){
        $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
      }
    }
  });

  // 画像の削除
  $(document).on('click', '.image-option__list--delete', function() {
    console.log('success')
    var count = $('.item-image-container__unit--preview').length;
    // setLabel(count);
    var id = $(this).parent().parent().parent().attr('image-data-id')
    $(this).parent().parent().parent().remove();

      //投稿編集時
      $(`#item_images_attributes_${id}__destroy`).prop('checked',true);
      //5個めが消されたらラベルを表示
      if (count == 4) {
        $('.label-content').show();
      }

      //ラベルのwidth操作
      // setLabel();
      //ラベルのidとforの値を変更
      //削除したプレビューのidによって、ラベルのidを変更する
      if(id < 5){
        $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      }
    });
    //=============================================================================
  };

  // items/newの時の処理
  if(window.location.href.match(/\/items\/new/)){
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  var files_array = [];

  function buildImage(loadedImageUri,i){
    var html =
      `<li class="item-image-container__unit--preview" image-data-id=${i}>
        <div class="item-image-container__unit--caption">
          <img src="${loadedImageUri}">
        </div>
        <div class="image-option">
          <div  class="image-option__list">
            <div class="image-option__list--edit">編集</div>
          </div>
          <div class="image-option__list">
            <div class="image-option__list--delete">削除</div>
          </div>
        </div>
      </li>`
    return html
  };

  function imageUpdate(files){
    $.each(files, function(i, file){
      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files
      $('.item-image-container__unit--preview').length + 1 + i
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();
      fileReader.readAsDataURL(file);

      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var loadedImageUri = fileReader.result
        var html = buildImage(loadedImageUri,i)
        $(html).appendTo(".item-image-container__unit ul").trigger("build");
      };
      if(dataBox.items.length > 4){
        return false;
      }
    });
  }
  //fileが選択された時に発火するイベント
   $('.image-upload-dropfile-hidden').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var files = this.files
    //newかeditで条件分岐させるべきか
    imageUpdate(files)
    $('#d-d-delete').css('display','none')
    $('#click-delete').css('display','none');
  });

  $('.item-image-container__unit--guide').on('dragover',function(e){
    e.preventDefault();
  });
  $('.item-image-container__unit--guide').on('drop',function(e){
    e.preventDefault();
    var files = e.originalEvent.dataTransfer.files;
    //newかeditで条件分岐させるべきか
    imageUpdate(files)
    $('#d-d-delete').css('display','none')
    $('#click-delete').css('display','none');
  });

  $(document).on('click','.image-option__list--delete',function(){
    var index = $(".image-option__list--delete").index(this);
    var i = $(this).parent().parent().parent().attr('image-data-id')
    files_array.splice(index - 1, 1);
    $(this).parent().parent().parent().remove();
    //newかeditで条件分岐させるべきか
    dataBox.items.remove(dataBox.items[i])
    file_field.files = dataBox.files
    if(dataBox.items.length == 0){
      $('#d-d-delete').css('display','block')
      $('#click-delete').css('display','block');
    }
  });
}

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
      $('.items-second__head--fourth').css('display','none');
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
          $('.items-second__head--fourth').css('display','block');
        } else {
          $('.items-second__head--second').append(insertHTML);
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
      $('.items-second__head--fourth').css('display','none');
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
          $('.items-second__head--fourth').css('display','none');
        } else {
          $('.items-second__head--third').append(insertHTML);
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
      $('.items-second__head--fourth').css('display','none');
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
          $('.items-second__head--fourth').css('display','block');
          $('.items-second__head--fourth').append(insertHTML);
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
      $(".items-third__center").css('display','none');
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
          $(".items-third__center").css('display','block');
          $('.items-third__center').append(insertHTML);
        };
      })
      .fail(function() {
        alert("サーバとの通信に失敗しました");
      });
    }
  });
});