// eslint-disable-next-line no-unused-vars,no-undef
class SlideshowController extends Stimulus.Controller {
  static get targets() {
    return [
      /**
       * @private
       * @property {HTMLElement[]} slideTargets - The slide elements.
       */
      'slide'
    ]
  }

  /**
   * Returns the incrementer.
   * @private
   * @return {Number} The value for the incrementer.
   */
  get incrementer() {
    return Number.parseInt(this.data.get('incrementer'))
  }

  /**
   * Sets the incrementer.
   * @private
   * @param value {Number} The new value for the incrementer.
   */
  set incrementer(value) {
    this.data.set('incrementer', value.toString())
    this.showSlide()
  }

  /**
   * Hook to start advancing the slides if necessary.
   * @private
   */
  connect() {
    this.showSlide()
    if (this.data.has('advance')) {
      setInterval(() => this.next(), 10000)
    }
  }

  /**
   * Shows the slide that corresponds to the incrementer and hides all others.
   * @private
   */
  showSlide() {
    this.slideTargets.forEach((target, index) => target.hidden = index !== this.incrementer)
  }

  /**
   * Increases the incrementer if there are more slides, or sets it to 0 if showing the last slide.
   * @private
   */
  next() {
    const incrementer = this.incrementer
    this.incrementer = incrementer === this.slideTargets.length - 1 ? 0 : incrementer + 1
  }

  /**
   * Decreases the incrementer if there are more slides, or sets it to 0 if showing the first slide.
   * @private
   */
  previous() {
    const incrementer = this.incrementer
    this.incrementer = incrementer === 0 ? this.slideTargets.length - 1 : incrementer - 1
  }
}
