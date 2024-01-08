import React from 'react';
import ReactDOM from 'react-dom';
import Layout from '@src/layout';
import { safeCredential, handleErrors } from '@utils/fetchHelper';
import './userBookings.scss';


class UserBookings extends React.Component {
    state = {
      bookings: [],
    };
  

    componentDidMount() {
      this.fetchUserBookings();
    }
  
   
    fetchUserBookings = () => {
      fetch('/api/bookings', {
        method: 'GET',
        credentials: 'include', 
      })
        .then((response) => response.json())
        .then((data) => {
            console.log(data);
          this.setState({
            bookings: data.bookings,
          });
        })
        .catch((error) => {
          console.error('Error fetching bookings:', error);
        });
    };
  
  
    handleStartCheckout = (bookingId) => {
        window.location.href = `/user_bookings/${bookingId}/checkout`;
    };
  
    render() {
      const { bookings } = this.state;
  
      return (
        <div>
          <h2>Your Bookings</h2>
          <ul>
            {bookings.map((booking) => (
              <li key={booking.id}>
                Booking ID: {booking.id}<br />
                Start Date: {booking.start_date}<br />
                End Date: {booking.end_date}<br />
                Paid: {booking.paid ? 'Yes' : 'No'}<br />
                {!booking.paid && (
                  <button onClick={() => this.handleStartCheckout(booking.id)}>
                    Start Checkout
                  </button>
                )}
                <hr />
              </li>
            ))}
          </ul>
        </div>
      );
    }
  }
  
  export default UserBookings;
  