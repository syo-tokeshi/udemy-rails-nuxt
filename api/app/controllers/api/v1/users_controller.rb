class Api::V1::UsersController < ApplicationController
    # 追加
    def index
      users = User.all
      render json: users.as_json(only: [:id, :name, :email, :created_at])
    end
  end