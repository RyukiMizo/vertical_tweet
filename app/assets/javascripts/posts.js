/* global $ */
$(document).on('turbolinks:load', function(){
    $(document).on('keyup', '#form', function(e){
    e.preventDefault();
    var input = $.trim($(this).val());
    $.ajax({
      url: '/posts/search',
      type: 'GET',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(data){ //データを受け取ることに成功したら、dataを引数に取って以下のことする(dataには@postsが入っている状態)
      $('#result').find('li').remove();  //idがresultの子要素のliを削除する
      $(data).each(function(i, post){ //dataをpostという変数に代入して、以下のことを繰り返し行う(単純なeach文)
        $('#result').append('<li>' + post.content + '</li>'); //resultというidの要素に対して、<li>post.content</li>を追加する。
      });
    });
  });
});