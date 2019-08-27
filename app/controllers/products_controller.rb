# frozen_string_literal: true

class ProductsController < ApplicationController
  expose :products, -> { ProductQuery.new.relation.all }
  expose :product, scope: -> { ProductQuery.new.relation },
                   find: ->(id, scope) { scope.find(id) }

  def inde; end

  def show; end

  def new; end

  def create
    if product.save
      flash[:success] = "Product successfully created"
      redirect_to product
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit; end

  def update
    if product.update_attributes(product_params)
      flash[:success] = "Product '%s' was successfully updated" % product.name
      redirect_to product
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if product.destroy
      flash[:success] = 'Product was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :code, :price)
  end
end
