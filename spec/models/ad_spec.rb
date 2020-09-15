require 'rails_helper'

describe Ad, type: :model do
  xcontext 'validation' do 
        it 'at least one image must be present' do
            ad = Ad.new(images:nil)
            ad.valid?
            expect(ad.errors[:images]).to include('É necessário uma imagem para publicar o anúncio')
        end
    end
end
