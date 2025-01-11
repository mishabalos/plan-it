import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  static values = {
    latitude: Number,
    longitude: Number,
    title: String
  }

  connect() {
    if (this.hasLatitudeValue && this.hasLongitudeValue) {
      this.initializeMap()
    }
  }

  initializeMap() {
    const map = new google.maps.Map(this.containerTarget, {
      center: { lat: this.latitudeValue, lng: this.longitudeValue },
      zoom: 15
    })

    new google.maps.Marker({
      position: { lat: this.latitudeValue, lng: this.longitudeValue },
      map: map,
      title: this.titleValue
    })
  }
} 