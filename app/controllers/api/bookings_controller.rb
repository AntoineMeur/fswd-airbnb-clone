module Api
    class BookingsController < ApplicationController
      def create
        token = cookies.signed[:airbnb_session_token]
        session = Session.find_by(token: token)
        return render json: { error: 'user not logged in' }, status: :unauthorized unless session
  
        @booking = Booking.new({
          property_id: params[:booking][:property_id],
          start_date: params[:booking][:start_date],
          end_date: params[:booking][:end_date],
          user_id: session.user.id,
          paid: false, 
        })
  
        if @booking.save
          render 'api/bookings/create', status: :created
        else
          render json: { error: 'booking could not be created' }, status: :bad_request
        end
      end
  
      def get_property_bookings
        property = Property.find_by(id: params[:id])
        return render json: { error: 'cannot find property' }, status: :not_found if !property
  
        @bookings = property.bookings.where("end_date > ? ", Date.today)
        render 'api/bookings/index'
      end
  
      private
  
      def booking_params
        params.require(:booking).permit(:property_id, :start_date, :end_date)
      end

      def index
        @bookings = Booking.where(user_id: session.user.id)
        render 'api/bookings/index'
      end
    end
  end