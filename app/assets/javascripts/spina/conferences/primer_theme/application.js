//= require stimulus
//= require_directory ./controllers
//= require turbolinks

// eslint-disable-next-line no-undef
const application = Stimulus.Application.start()
// eslint-disable-next-line no-undef
application.register('slideshow', SlideshowController)
