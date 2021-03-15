//= require stimulus
//= require_directory ./controllers

// eslint-disable-next-line no-undef
const application = Stimulus.Application.start()
// eslint-disable-next-line no-undef
application.register('slideshow', SlideshowController)
