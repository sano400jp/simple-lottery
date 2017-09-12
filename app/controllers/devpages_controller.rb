class DevpagesController < ApplicationController
    def cacheedit
        @cachestr_owner_code = session[:owner_code]
        @cachestr_lottery_code = session[:lottery_code]
    end
end