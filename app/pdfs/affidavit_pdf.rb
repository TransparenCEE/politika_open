# -*- encoding : utf-8 -*-
class AffidavitPdf < Prawn::Document
  
  def initialize(current_user)
    super()
    @current_user = current_user
    load_font
    title
    body_text
    signature
    user_stamp
  end
  
  def load_font
    font "#{Rails.root}/data/arial.ttf"
  end
  
  def title
    font_size 15
    text "Čestné prehlásenie\n\n", align: :center
  end
  
  def body_text
    font_size 9
    
    text "Ja, #{@current_user.full_name}, narodený #{I18n.l(@current_user.basic_information_date_of_birth)}, čestne vyhlasujem, že udeľujem súhlas so spracúvaním osobných údajov v rozsahu registračného formulára, ktorý sa nachádza na internetovej stránke www.politikaopen.sk, a ktorý som vyplnil/a v rámci projektu politikaopen. Udeľujem súhlas so spracúvaním osobných údajov vo vymedzenom rozsahu na účel informovania verejnosti o majetku, záujmoch a osobných väzbách verejných funkcionárov a osôb kandidujúcich na verejnú funkciu. Výslovne udeľujem súhlas so spracúvaním osobných údajov týkajúcich sa môjho členstva v politických stranách alebo politických hnutiach. Zároveň udeľujem súhlas so spracúvaním osobných údajov pre účely prihlasovania sa na internetovej stránke www.politikaopen.sk. Súhlas udeľujem s vedomím, že rozsah registračného formulára, ktorý sa nachádza na internetovej stránke www.politikaopen.sk, sa môže meniť a v prípade, že v ňom doplním ďalšie údaje, tak tým potvrdím jasne svoju vôľu s poskytovaním údajov aj v rámci nového rozsahu registračného formulára. Súhlas so spracúvaním osobných údajov udeľujem na dobu 12 rokov odo dňa udelenia súhlasu so spracovaním osobných údajov. Súhlas so spracúvaním osobných údajov dávam za podmienky, že ho môžem odvolať v nasledujúcich prípadoch

    \n\n - ak prevádzkovateľ použije osobné údaje na iný účel, než na aký boli moje osobné údaje poskytnuté,

    \n\n - po uplynutí 12 rokov odo dňa poskytnutia súhlasu so spracúvaním osobných údajov; skôr je možné súhlas odvolať iba v prípade, že som zo zdravotných dôvodov alebo z dôvodu veku preukázateľne ukončil/a svoje pôsobenie vo verejnom sektore, v tomto prípade je možné odvolať súhlas so spracúvaním osobných údajov po uplynutí dvoch rokov odo dňa ukončenia pôsobenia vo verejnom sektore,

    \n\n - ak som kandidátom/kandidátkou na verejnú funkciu, po uplynutí 90 dní odo dňa konania volieb alebo výberového konania, pokiaľ som vo voľbách alebo vo výberovom konaní nebol/a úspešný/a a súčasne nezastávam k dňu podpísania tohto čestného prehlásenia alebo k 90. dňu po konaní volieb alebo výberového konania inú verejnú funkciu.\n\n", :leading => 4
    
    text "Svojím podpisom zároveň potvrdzujem, že som bol/a poučený/a o existencii  práv dotknutej osoby.", :leading => 4
    
    text "\n\n\n\n\n\n\n"
  end
  
  def signature
    text "V ________________________, dňa _____________________", :align => :right
    text "\n\n\n\n\n"
    
    text "__________________________", :align => :right
    text "podpis", :align => :right
  end
  
  def user_stamp
    move_cursor_to 20
    font_size 7
    text "#{@current_user.id}"
  end
  
end