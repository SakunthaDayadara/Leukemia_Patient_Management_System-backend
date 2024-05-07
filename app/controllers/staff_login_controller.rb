class StaffLoginController < ApplicationController
  before_action -> { authorized("staff") }, only: [:staff_auto_login]
  before_action -> { authorized(["admin"]) }, only: [:admin_auto_login]
  def login
    # Assuming params[:username] and params[:password] are provided in the request

    user = nil
    role = nil
    token = nil

    # Check if the credentials match a doctor
    doctor = Doctor.find_by(username: params[:username])
    if doctor && doctor.authenticate(params[:password])
      user = doctor
      role = "doctor"
      token = JsonWebToken.encode(user_id: doctor.doctor_id, role: role)
    end

    # If not already found, check if the credentials match a nurse
    unless user
      nurse = Nurse.find_by(username: params[:username])
      if nurse && nurse.authenticate(params[:password])
        user = nurse
        role = "nurse"
        token = JsonWebToken.encode(user_id: nurse.nurse_id, role: role)
      end
    end

    # If not already found, check if the credentials match an admin
    unless user
      admin = Admin.find_by(username: params[:username])
      if admin && admin.authenticate(params[:password])
        user = admin
        role = "admin"
        token = JsonWebToken.encode(user_id: admin.admin_id, role: role)
      end
    end

    if user
      render json: {  token: token, username: user.username, user_id: user.id, role: role }
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def staff_auto_login
    user_id = nil

    case @decoded[:role]
    when "doctor"
      user_id = Doctor.find_by(username: @current_user.username)&.doctor_id
    when "admin"
      user_id = Admin.find_by(username: @current_user.username)&.admin_id
    when "nurse"
      user_id = Nurse.find_by(username: @current_user.username)&.nurse_id
    end

    if user_id
      render json: { username: @current_user.username, user_id: user_id, role: @decoded[:role] }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def admin_auto_login
    user_id = Admin.find_by(username: @current_user.username)&.admin_id
    render json: { username: @current_user.username, user_id: user_id, role: @decoded[:role] }, status: :ok
  end

  private


end
