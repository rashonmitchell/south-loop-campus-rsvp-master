SouthLoopCampusRsvp::Application.routes.draw do
  root to: "application#home"
  resources :rsvps, only: [:create, :index]

  post :notify, to: "logs#notify"
  resources :logs, only: :index
end
