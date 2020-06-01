import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['output']

  showOutput(event) {
    let [data, status, xhr] = event.detail

    if (data.output) {
      this.outputTarget.textContent = data.output
      this.outputTarget.classList.add('calculated')

      if (data.output == this.emptyOutput) {
        this.outputTarget.classList.remove('calculated')
      }
    }
  }

  get emptyOutput() {
    return this.data.get('empty-output')
  }
}
