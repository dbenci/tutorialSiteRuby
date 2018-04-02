class @animationButton
  constructor: ()->
    @buttonContainer = document.querySelector '.download-button-container' 
    @ball = @buttonContainer.querySelector '.button-ball'
    @button = @buttonContainer.querySelector '.download-button' 
    @circularProgress = @buttonContainer.querySelector '.button-circular-progress' 
    @circularProgressLength = @circularProgress.getTotalLength()
    @linearProgress = @buttonContainer.querySelector '.button-linear-progress-bar' 
    @iconSquarePath = @buttonContainer.querySelector '.button-icon-path-square' 
    @borderPath = @buttonContainer.querySelector '.border-path' 
    @iconLinePath = @buttonContainer.querySelector '.button-icon-path-line' 

    @iconSquare = new Segment @iconSquarePath, '30%', '70%'
    @circularProgressBar = new Segment @circularProgress, 0, 0 
    @iconLine = new Segment @iconLinePath, 0, '100%' 
    @downloading = false
    @completed = false
    @progressTimer = 0

   startDownload: ()=>
    @downloading = true
    @buttonContainer.classList.add 'downloading' 
    @animateIcon()
    utilitiesObject = this
    onProggresAction = -> 
      utilitiesObject.buttonContainer.classList.add 'progressing'
      utilitiesObject.animateProgress();
    @progressTimer = setTimeout onProggresAction, 1000 

  stopDownload: ()=>
    @downloading = false
    clearTimeout @progressTimer
    @buttonContainer.classList.remove 'progressing'
    @buttonContainer.classList.remove 'downloading' 
    @stopProgress()
    @iconSquare.draw '30%', '70%', 1, {easing: anime.easings['easeOutQuad']}
    @iconLine.draw 0, '100%', 1, {easing: anime.easings['easeOutCubic']}
    
  animateIcon: ()=>
    @iconLine.draw 0, 0, 0.5
    @iconSquare.draw 0, '100%', 1

  stopProgress: ()=>
    @circularProgressBar.stop()
    @circularProgressBar.draw 0, 0, 0
    @updateProgress @circularProgressBar, true

  updateProgress: (instance, keepBallPosition) =>
    if not keepBallPosition
      point = instance.path.getPointAtLength instance.end
      @ball.style.transform = 'translate(' + point.x + 'px, ' + point.y + 'px)'

  animateProgress: ()=>
    @circularProgressBar.draw 0, '100%', 2.5,  {easing: anime.easings['easeInQuart'], update: @updateProgress, callback: @completedAnimation}
  
  completedAnimation: ()=>
    @completed = true
    @buttonContainer.classList.add 'completed'
    utilitiesObject = this
    timeOutFuntion = ->
      utilitiesObject.ball.classList.add 'hidden'
      utilitiesObject.button.classList.add 'button-hidden'
      utilitiesObject.borderPath.classList.remove 'hidden'
      onCompleteOuterFuntion = ->
        onCompleteInnerFuntion = ->
          utilitiesObject.completed = false
          innerTimeout = ->
            utilitiesObject.button.classList.remove 'button-hidden'
            utilitiesObject.buttonContainer.classList.remove 'completed'
            utilitiesObject.ball.classList.remove 'hidden'
            utilitiesObject.borderPath.classList.add 'hidden'
            utilitiesObject.stopDownload()
          setTimeout innerTimeout, 500
        morph = anime targets: utilitiesObject.borderPath, 
        d: 'M 40 3.5 a 36.5 36.5 0 0 0 -36.5 36.5 a 36.5 36.5 0 0 0 36.5 36.5 C 70 76.5 90 76.5 120 76.5 S 170 76.5 200 76.5 a 36.5 36.5 0 0 0 36.5 -36.5 a 36.5 36.5 0 0 0 -36.5 -36.5 Z', 
        duration: 1000, 
        elasticity: 600, 
        complete: onCompleteInnerFuntion
      morph = anime targets: utilitiesObject.borderPath,
      d: 'M 40 3.5 a 36.5 36.5 0 0 0 -36.5 36.5 a 36.5 36.5 0 0 0 10.5 26.5 C 35 86.5 90 91.5 120 91.5 S 205 86.5 226 66.5 a 36.5 36.5 0 0 0 10.5 -26.5 a 36.5 36.5 0 0 0 -36.5 -36.5 Z',
      duration: 100,
      easing: 'linear',
      complete: onCompleteOuterFuntion
    setTimeout timeOutFuntion, 1000
        