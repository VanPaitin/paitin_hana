require "spec_helper"

module PaitinHana
  module Routing
    class Router
      attr_reader :route_info

      def draw(&block)
        instance_eval(&block)
        self
      end
    end
  end
end

describe PaitinHana::Routing::Router do
  def draw(&block)
    router = PaitinHana::Routing::Router.new
    router.draw(&block).route_info
  end

  context "endpoints" do
    context "get '/photos', to: 'photos#index'" do
      subject do
        draw { get "/photos", to: "photos#index" }
      end

      route_info = {
        path: "/photos",
        pattern: [%r{^/photos$}, []],
        class_and_method: ["PhotosController", :index]
      }

      it { is_expected.to eq route_info }
    end

    context "get '/photos/:id', to: 'photos#show'" do
      subject do
        draw { get "/photos/:id", to: "photos#show" }
      end

      route_info = {
        path: "/photos/:id",
        pattern: [%r{^/photos/(?<id>\w+)$}, ["id"]],
        class_and_method: ["PhotosController", :show]
      }

      it { is_expected.to eq route_info }
    end

    context "get '/photos/:id/edit', to: 'photos#edit'" do
      subject do
        draw { get "/photos/:id/edit", to: "photos#edit" }
      end

      regexp = %r{^/photos/(?<id>\w+)/edit$}
      route_info = {
        path: "/photos/:id/edit",
        pattern: [regexp, ["id"]],
        class_and_method: ["PhotosController", :edit]
      }

      it { is_expected.to eq route_info }
    end

    context "get 'album/:album_id/photos/:photo_id',to: 'photos#album_photo'" do
      subject do
        draw do
          get "/album/:album_id/photos/:photo_id",
              to: "photos#album_photo"
        end
      end

      regexp = %r{^/album/(?<album_id>\w+)/photos/(?<photo_id>\w+)$}
      route_info = {
        path: "/album/:album_id/photos/:photo_id",
        pattern: [regexp, %w(album_id photo_id)],
        class_and_method: ["PhotosController", :album_photo]
      }

      it { is_expected.to eq route_info }
    end
  end
end
