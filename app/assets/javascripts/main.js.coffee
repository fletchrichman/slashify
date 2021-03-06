class @Slashify

  @boot: ->

    $(window).on('scroll', @hideFooterOnScroll)

    @preloadImage(=>
      @loadInitialPhotos()
      @initializePusher()
    )

  @preloadImage = (callback) ->

    image = new Image()
    image.src = '/assets/slash.png'

    $(image).on('load', callback)

  @loadInitialPhotos = ->

    $.ajax(
      url: '/photos.json',
      success: (photos) => $(photos).each((key, value) => @renderPhoto(value, true))
    )

  @initializePusher: ->

    pusher  = new Pusher('4dde7f554a0557b9efbd')
    channel = pusher.subscribe('slash')
    channel.bind('new_photo', @renderPhoto)

  @hideFooterOnScroll = ->

    scrollTop = $(window).scrollTop()

    $('footer .disclaimer').toggleClass('hidden', scrollTop > 100)

  # Horrible convenience function to render a photo
  @renderPhoto = (photo, append = false) ->

    image = new Image()
    image.src = photo.photo_url

    $(image).on('load', ->

      return if append && $('.grid .photo').length >= 25

      gridElement = $('<div />').attr('class', 'pure-u-1-5 photo')

      $('<img />').attr('src', photo.photo_url).attr('data-id', photo.internal_id).appendTo(gridElement)
      
      $(photo.faces).each(->

        $('<div class="face"><img src="/assets/slash.png"></div>')
          .css('top', "#{@top-(@width*0.87/2)}%")
          .css('left', "#{@left-(@width*0.87/2)}%")
          .css('width', "#{@width*1.87}%")
          .appendTo(gridElement)

      )

      gridElement[if append then 'appendTo' else 'prependTo']('.grid')

      if $('.grid .photo').length > 25
        target = if append then 'first' else 'last'
        $(".grid .photo:#{target}").remove()

      setTimeout(->

        gridElement.addClass('visible')

      , 50)

    )

@Slashify.boot()