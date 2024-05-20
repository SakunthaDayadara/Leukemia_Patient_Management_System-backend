Rails.application.routes.draw do
  resources :appointments do
    collection do
      get 'find_by_patient'
      get 'find_by_appointment_id'
      get 'find_by_date_and_patient_gender'
      get 'confirm_appointment'
      delete 'delete_by_appointment_id'
      patch 'nurse_confirm_appointment'
      patch 'make_reschedule'
      get 'make_reschedule_table'
      patch 'make_reschedule_done'
      get 'ongoing_appointment'
      patch 'make_appointment_done'
      get 'finished_appointment'
    end
  end
  resources :nurses do
    collection do
      get 'find_by_nurse_id'
      post 'reset_password'
      get 'get_ward_gender'
    end
  end
  resources :wards
  resources :admins do
    collection do
      get 'find_by_admin_id'
    end
  end
  resources :doctors do
    collection do
      get 'find_by_doctor_id'
      post 'reset_password'
    end
  end
  resources :patients do
    collection do
      get 'find_by_patient_id'
      get 'auto_login'
      post 'login'
      patch 'make_appointment'
      get 'initial_appointment'
      patch 'make_test_done'
      get 'test_done'
      delete 'delete_by_patient_id'
    end
  end

  post 'stafflogin', to: 'staff_login#login'
  get 'staffautologin', to: 'staff_login#staff_auto_login'
  get 'adminautologin', to: 'staff_login#admin_auto_login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
