

animation_button = new animationButton

console.log 'test'
console.log @questionForFrontend

console.log $('.questionForFrontend').data('questions')

q = $('.questionForFrontend').data('questions')

for d in q
  console.log d


onClickAction = ->
  if not animation_button.completed
    if animation_button.downloading
      animation_button.stopDownload()
    else
      animation_button.startDownload()
document.addEventListener 'click', onClickAction

loading = $('#loadbar').hide()

$(document).ajaxStart -> 
            loading.show()
          .ajaxStop ->
            loading.hide()

questionNo = 0
correctCount = 0

q = [
        {'Q':'How do you write "Hello World" in an alert box?', 'A':2,'C':['msg("Hello World");','alert("Hello World");','alertBox("Hello World");']},
        {'Q':'How do you create a function in JavaScript?', 'A':3,'C':['function:myFunction()','function = myFunction()','function myFunction()']},
        {'Q':'How to write an IF statement in JavaScript?', 'A':1,'C':['if (i == 5)','if i = 5 then','if i == 5 then']},
        {'Q':'How does a FOR loop start?', 'A':2,'C':['for (i = 0; i <= 5)','for (i = 0; i <= 5; i++)','for i = 1 to 5']},
        {'Q':'What is the correct way to write a JavaScript array?', 'A':3,'C':['var colors = "red", "green", "blue"','var colors = (1:"red", 2:"green", 3:"blue")','var colors = ["red", "green", "blue"]']}
    ]

$(document.body).on 'click', 'label.element-animation', (e)-> 
  parent = $(this)
  if parent.find('.ink').length is 0
    parent.prepend "<span class='ink'></span>"

  ink = parent.find ".ink"
  ink.removeClass "animate"

  if not ink.height() and not ink.width()
    d = Math.max parent.outerWidth(), parent.outerWidth()
    ink.css {height: "100px", width: "100px"}

  x = e.pageX - parent.offset().left - ink.width()/2
  y = e.pageY - parent.offset().top - ink.height()/2

  ink.css {top: y+'px', left: x+'px'}
     .addClass("animate")

  choice = $(this).parent().find('input:radio').val()
  console.log $(this)
  anscheck = $(this).checking questionNo, choice
  q[questionNo].UC = choice
  if anscheck
    correctCount = correctCount + 1
    q[questionNo].result = "Correct"
  else
    q[questionNo].result = "Incorrect"
  
  setTimeout ->
    $('#loadbar').show()
    $('#quiz').fadeOut()
    questionNo = questionNo + 1
    if (questionNo + 1) > q.length
      alert "Quiz completed, Now click ok to get your answer"
      $('label.element-animation').unbind('click')
      setTimeout ->
        toAppend = ''
        $.each q, (i, a) ->
          toAppend += '<tr>'
          toAppend += '<td>'+(i+1)+'</td>'
          toAppend += '<td>'+a.A+'</td>';
          toAppend += '<td>'+a.UC+'</td>';
          toAppend += '<td>'+a.result+'</td>';
          toAppend += '</tr>'
        $('#quizResult').html(toAppend);
        $('#totalCorrect').html("Total correct: " + correctCount);
        $('#quizResult').show();
        $('#loadbar').fadeOut();
        $('#result-of-question').show();
        $('#graph-result').show();
        chartMake();
      ,1000
    else
      $('#qid').html questionNo + 1 
      $('input:radio').prop 'checked', false
      setTimeout ->
        $('#quiz').show()
        $('#loadbar').fadeOut()
      ,1500
      $('#question').html(q[questionNo].Q);
      $($('#f-option').parent().find('label')).html(q[questionNo].C[0]);
      $($('#s-option').parent().find('label')).html(q[questionNo].C[1]);
      $($('#t-option').parent().find('label')).html(q[questionNo].C[2]);
  ,1000  

console.log 'IM HERE DOWN'

$.fn.checking = (qstn, ck) ->
  ans = q[questionNo].A
  if parseInt(ck) is parseInt(ans)
    console.log 'Im Here'
    true
  else
    console.log 'Im in else Here'
    false

chartMake = ->
  dataProvider = [
    
      "name": "Correct",
      "points": correctCount,
      "color": "#00FF00",
      "bullet": "http://i2.wp.com/img2.wikia.nocookie.net/__cb20131006005440/strategy-empires/images/8/8e/Check_mark_green.png?w=250"
    ,
      "name": "Incorrect",
      "points": q.length-correctCount,
      "color": "red",
      "bullet": "http://4vector.com/i/free-vector-x-wrong-cross-no-clip-art_103115_X_Wrong_Cross_No_clip_art_medium.png"
    
  ]
  valueAxes = [
                "maximum": q.length,
                "minimum": 0,
                "axisAlpha": 0,
                "dashLength": 4,
                "position": "left"
              ]
  graphs = [
            "balloonText": "<span style='font-size:13px;'>[[category]]: <b>[[value]]</b></span>",
            "bulletOffset": 10,
            "bulletSize": 52,
            "colorField": "color",
            "cornerRadiusTop": 8,
            "customBulletField": "bullet",
            "fillAlphas": 0.8,
            "lineAlpha": 0,
            "type": "column",
            "valueField": "points"
          ]
  categoryAxis = 
                "axisAlpha": 0,
                "gridAlpha": 0,
                "inside": true,
                "tickLength": 0

  chart = AmCharts.makeChart "chartdiv",
  "type" : "serial",
  "theme" : "dark",
  "dataProvider" : dataProvider,
  "valueAxes" : valueAxes,
  "startDuration" : 1,
  "graphs" : graphs
  "marginTop": 0,
  "marginRight": 0,
  "marginLeft": 0,
  "marginBottom": 0,
  "autoMargins": false,
  "categoryField": "name",      
  "categoryAxis": categoryAxis
