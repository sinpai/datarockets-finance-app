require 'rails_helper'

RSpec.context CategoriesController, type: :controller do
  context 'when logged in' do
    let(:category) { create(:category, :top_category) }

    login_user

    context 'when asking for new category' do
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    context 'when asking for edit category' do
      it 'renders the :edit template' do
        get :edit, params: {id: category.id}
        expect(response).to render_template :edit
      end
    end

    context 'when viewing index' do
      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    context 'when creating new category' do
      context 'when valid' do
        it 'category has been created' do
          expect do
            post :create, params: {category: attributes_for(:category)}
          end.to change(Category, :count).by(1)
        end

        it 'redirects after create' do
          post :create, params: {category: attributes_for(:category)}
          expect(response).to redirect_to categories_path
        end
      end

      context 'when not valid' do
        it 'new category has not been created' do
          expect do
            post :create, params: {category: {name: nil}}
          end.not_to change(Category, :count)
        end

        it 'redirect to categories path' do
          post :create, params: {category: {name: nil}}
          expect(response).to redirect_to categories_path
        end
      end
    end

    context 'when updating category' do
      context 'when valid' do
        let(:amount) { Faker::Number.digit }
        let(:name) { Faker::Internet.user_name(5..15) }
        let(:params) do
          {
            id: category.id,
            category: attributes_for(:category,
              amount: amount,
              name: name)
          }
        end

        before do
          put :update, params: params
          category.reload
        end

        it 'updates category amount' do
          expect(category.amount).to eq(amount.to_f)
        end

        it 'updates category name' do
          expect(category.name).to eq(name)
        end

        it 'redirects after update' do
          put :update, params: {id: category.id, category: attributes_for(:category)}
          expect(response).to  redirect_to categories_path
        end
      end

      context 'when not valid' do
        let(:init_amount) { category.amount }
        let(:init_name) { category.name }
        let(:params) do
          {
            id: category.id,
            category: attributes_for(:category,
              amount: nil,
              name: nil)
          }
        end

        before do
          put :update, params: params
          category.reload
        end

        it 'not updates category amount' do
          expect(category.amount).to eq(init_amount)
        end

        it 'not updates category name' do
          expect(category.name).to eq(init_name)
        end

        it 'redirect to categories path' do
          put :update, params: {
            id: category.id,
            category: attributes_for(:category, amount: nil, name: nil)
          }
          expect(response).to redirect_to categories_path
        end
      end
    end

    context 'when deleting category' do
      let!(:category) { create(:category, :top_category) }

      it 'destroys category' do
        expect do
          delete :destroy, params: {id: category.id}
        end.to change(Category, :count).by(-1)
      end
    end
  end
end
