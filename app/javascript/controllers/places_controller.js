import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (typeof google === 'undefined') return
    
    this.autocomplete = new google.maps.places.Autocomplete(this.element)
    this.autocomplete.addListener('place_changed', () => this.placeSelected())
  }
  
  placeSelected() {
    const place = this.autocomplete.getPlace()
    if (!place.geometry) return
    
    const form = this.element.closest('form')
    form.querySelector('[name*="latitude"]').value = place.geometry.location.lat()
    form.querySelector('[name*="longitude"]').value = place.geometry.location.lng()
    form.querySelector('[name*="location_name"]').value = place.name
    
    // Only for activities
    const formattedAddressField = form.querySelector('[name*="formatted_address"]')
    if (formattedAddressField) {
      formattedAddressField.value = place.formatted_address
    }
  }
} 