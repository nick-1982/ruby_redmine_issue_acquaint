# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'acquaints/new', :to => 'acquaint#new', as: 'new_acquaints'
post 'acquaints/add', :to => 'acquaint#add', as: 'add_acquaints'
get 'acquaint/create/:id', :to => 'acquaint#create', as: 'create_acquaint'
delete 'acquaint/destroy/:id' => 'acquaint#destroy', as: 'destroy_acquaint'
