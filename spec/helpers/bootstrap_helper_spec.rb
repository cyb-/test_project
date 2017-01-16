require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do

	describe "#bootstrap_flash_class_for" do
		it "return valid Bootstrap class for flash message" do
			expect(helper.bootstrap_flash_class_for(:success)).to eq("alert-success")
		end

		it "return default 'alert-info' class" do
			expect(helper.bootstrap_flash_class_for(:invalid_type)).to eq("alert-info")
		end
	end

end
