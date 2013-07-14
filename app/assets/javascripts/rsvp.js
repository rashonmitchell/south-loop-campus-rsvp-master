$.fn.serializeJSON = function() {
  var json
  json = {}
  _($(this).serializeArray()).each(function(field) {
    return json[field.name] = field.value
  })
  return json
};

(function() {
  var spinner = new Spinner()
    , $inputs = $('.b-inputs')
    , $formInputs = $('.b-form-inputs')
    , onSuccess = function() {
      spinner.spin(false)
      $('.spinner').hide()
      $('.thank-you').show()
  }

  $('.ill-be-there').click(function() {
    $inputs.slideToggle(100, function() {
      $inputs.css('display') == 'block' && $(window).scrollTop($inputs.offset().top)
    })
  })

  $('.done-done').click(function() {
    if (_($('.b-inputs input').serializeJSON())
      .chain()
      .toArray()
      .compact()
      .value().length < 3) return (function() {
        $('input').each(function(input) {
          var $this = $(this)
          if(!$this.val()) return ($this.focus() && false)
        })
      })()

    $formInputs.hide()
    spinner.spin($('.spinner').show()[0])
    var $form = $('.b-rsvp-form')
      , data = $form.serializeJSON()
      $.post('/rsvps', data, onSuccess)
  })
})()

