import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "select", "chosen" ]

  connect() {
    this.updateChosen()
  }

  updateChosen() {
    const template = document.getElementById('user-badge-template').content;
    this.chosenTarget.innerHTML = '';
    Array.from(this.selectTarget.selectedOptions).forEach(option => {
      const clone = document.importNode(template, true);
      clone.querySelector('[data-role="user-name"]').textContent = option.text;
      const removeButton = clone.querySelector('button');
      removeButton.dataset.userId = option.value;
      this.chosenTarget.appendChild(clone);
    });
  }

  removeUser(event) {
    const userId = event.currentTarget.dataset.userId;
    const option = Array.from(this.selectTarget.options).find(option => option.value === userId);
    if (option) {
      option.selected = false;
      this.updateChosen();
    }
  }
}
