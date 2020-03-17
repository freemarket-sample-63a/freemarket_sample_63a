$(document).on('turbolinks:load', function() {
  if (document.getElementById("token_submit") != null) { 
    // Payjp.setPublicKey(gon.payip_access_key); 
    // alert(gon.payip_access_key);
    // alert('success');
    // console.log(gon.payip_access_key);
    // console.log('success');
    
    let btn = document.getElementById("token_submit"); 
    btn.addEventListener("click", e => { 
      e.preventDefault();
      Payjp.setPublicKey(gon.payip_access_key); 
      alert(gon.payip_access_key);
      alert('success');
      console.log(gon.payip_access_key);
      console.log('success');
      let card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
      };
      console.log(card)
      Payjp.createToken(card, (status, response) => {
        console.log(status)
        console.log(response)
        if (status === 200) { 
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); 
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); 
          document.inputForm.submit();
          alert("登録が完了しました"); 
        } else {
          alert("カード情報が正しくありません。"); 
        }
      });
    });
  };
});
