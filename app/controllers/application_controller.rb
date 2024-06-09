class ApplicationController < ActionController::API

  def authorized(roles_required)
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      case roles_required
      when "patient"
        @current_user = Patient.find(@decoded[:user_id])
      when "staff"
        if @decoded[:role] == "doctor"
          @current_user = Doctor.find(@decoded[:user_id])
        elsif @decoded[:role] == "admin"
          @current_user = Admin.find(@decoded[:user_id])
        elsif @decoded[:role] == "nurse"
          @current_user = Nurse.find(@decoded[:user_id])
        else
          # Handle other staff roles here if necessary
        end
      when "all"
        case @decoded[:role]
        when "doctor"
          @current_user = Doctor.find(@decoded[:user_id])
        when "admin"
          @current_user = Admin.find(@decoded[:user_id])
        when "nurse"
          @current_user = Nurse.find(@decoded[:user_id])
        when "patient"
          @current_user = Patient.find(@decoded[:user_id])
        else
          # Handle other roles here if necessary
        end
      when Array
        if roles_required.include?(@decoded[:role])
          case @decoded[:role]
          when "doctor"
            @current_user = Doctor.find(@decoded[:user_id])
          when "admin"
            @current_user = Admin.find(@decoded[:user_id])
          when "nurse"
            @current_user = Nurse.find(@decoded[:user_id])
          else
            # Handle other staff roles here if necessary
          end
        else
          render json: { errors: "Unauthorized" }, status: :unauthorized
          return
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end


  # Method to format phone number
  def format_phone_number(phone_number)
    last_nine_digits = phone_number[-9..-1]
    formatted_number = "+94" + last_nine_digits
    formatted_number
  end




end
