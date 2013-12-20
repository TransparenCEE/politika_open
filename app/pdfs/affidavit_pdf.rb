# -*- encoding : utf-8 -*-
class AffidavitPdf < Prawn::Document

  def initialize(current_user)
    super(margin: [80, 80])
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
    text "SÚHLAS SO SPRACOVANÍM OSOBNÝCH ÚDAJOV\n\n", align: :center
  end

  def body_text
    font_size 11

    text "Ja, #{@current_user.full_name}, narodený/á #{I18n.l(@current_user.basic_information_date_of_birth)}, čestne vyhlasujem, že udeľujem súhlas so spracúvaním osobných údajov v rozsahu registračného formulára, ktorý sa nachádza na internetovej stránke www.politikaopen.sk, a ktorý som vyplnil/a v rámci projektu politikaopen. Udeľujem súhlas so spracúvaním osobných údajov vo vymedzenom rozsahu na účel informovania verejnosti o majetku, záujmoch a osobných väzbách verejných funkcionárov a osôb kandidujúcich na verejnú funkciu. Výslovne udeľujem súhlas so spracúvaním osobných údajov týkajúcich sa môjho členstva v politických stranách alebo politických hnutiach. Zároveň udeľujem súhlas so spracúvaním osobných údajov pre účely prihlasovania sa na internetovej stránke www.politikaopen.sk. Súhlas udeľujem s vedomím, že rozsah registračného formulára, ktorý sa nachádza na internetovej stránke www.politikaopen.sk, sa môže meniť a v prípade, že v ňom doplním ďalšie údaje, tak tým potvrdím jasne svoju vôľu s poskytovaním údajov aj v rámci nového rozsahu registračného formulára. Súhlas so spracúvaním osobných údajov udeľujem na dobu 12 rokov odo dňa udelenia súhlasu so spracovaním osobných údajov."

    text "\n\nSvojím podpisom zároveň potvrdzujem, že som bol/a poučený/a o existencii  práv dotknutej osoby.", :leading => 4

    text "\n\n\n\n\n\n\n"
  end

  def signature
    text "V ________________________, dňa _____________________"
    text "\n\n\n\n\n"

    text "__________________________"
    text "podpis"
  end

  def user_stamp
    move_cursor_to 20
    font_size 7
    text "#{@current_user.id}"
  end

end
