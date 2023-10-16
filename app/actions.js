'use server'

import { redirect } from 'next/navigation'

export async function AddPassengers(prevState, formData) {
    try {
        console.log(formData.get('firstName2'))
    } catch (e) {
      return { message: 'Failed to create' }
    }
    redirect('/booking/selectSeats')
  }