require 'rails_helper'

RSpec.feature "Password Reset", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  context "when a user forgets their password" do

    scenario "user sees a 'Forgot your password?' link on the sign in page" do
      visit new_user_session_path

      expect(page).to have_content("Esqueceu sua senha?")
    end


    scenario "user can reset their password" do
      visit new_user_session_path

      click_on "Esqueceu sua senha?"
      expect(page).to have_current_path(new_user_password_path)

      fill_in "user_email", with: user.email
      click_button "Me mande as instruções de recuperação de senha"

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.")
      expect(Devise.mailer.deliveries.count).to eq 1

      visit password_reset_url(get_reset_password_token_from_email)

      fill_in "user_password", with: "new_password"
      fill_in "user_password_confirmation", with: "new_password"
      click_button "Mudar minha senha"

      expect(page).to have_content("Sua senha foi alterada com sucesso. Você está logado.")
      expect(page).to have_current_path(root_path)
    end
  end
end

def password_reset_url(token)
  "#{edit_user_password_path}?reset_password_token=#{token}"
end


def get_reset_password_token_from_email
  email_message = Devise.mailer.deliveries[0].body.raw_source
  token_index = email_message.index("reset_password_token") + "reset_password_token".length + 1
  email_message[token_index...email_message.index("\"", token_index)]
end
