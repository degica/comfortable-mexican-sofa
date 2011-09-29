Rails.application.routes.draw do
  
  namespace :cms_admin, :path => ComfortableMexicanSofa.config.admin_route_prefix, :except => :show do
    get '/', :to => 'base#jump'
    resources :sites do
      resources :pages do
        get  :form_blocks,    :on => :member
        get  :toggle_branch,  :on => :member
        post :reorder,        :on => :collection
        resources :revisions, :only => [:index, :show, :revert] do
          put :revert, :on => :member
        end
      end
      resources :files do
        post :reorder, :on => :collection
      end
      resources :layouts do
        post :reorder, :on => :collection
        resources :revisions, :only => [:index, :show, :revert] do
          put :revert, :on => :member
        end
      end
      resources :snippets do
        post :reorder, :on => :collection
        resources :revisions, :only => [:index, :show, :revert] do
          put :revert, :on => :member
        end
      end
      resources :categories
    end
  end unless ComfortableMexicanSofa.config.admin_route_prefix.blank?
  
  scope :controller => :cms_content do
    get 'cms-css/:site_id/:layout_slug' => :render_css,  :as => 'cms_css'
    get 'cms-js/:site_id/:layout_slug'  => :render_js,   :as => 'cms_js'
    get '/' => :render_html,  :as => 'cms_html',  :path => "(*cms_path)"
  end
  
end
