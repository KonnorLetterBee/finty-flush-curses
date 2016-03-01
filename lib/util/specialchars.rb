$CH_BOX_SCUL = $┌ = '┌'
$CH_BOX_SCUR = $┐ = '┐'
$CH_BOX_SCDL = $└ = '└'
$CH_BOX_SCDR = $┘ = '┘'
$CH_BOX_SSH  = $─ = '─'
$CH_BOX_SSV  = $│ = '│'

$CH_BOX_SJU  = $┴ = '┴'
$CH_BOX_SJD  = $┬ = '┬'
$CH_BOX_SJL  = $┤ = '┤'
$CH_BOX_SJR  = $├ = '├'
$CH_BOX_SJ   = $┼ = '┼'

$CH_BOX_DCUL = $╔ = '╔'
$CH_BOX_DCUR = $╗ = '╗'
$CH_BOX_DCDL = $╚ = '╚'
$CH_BOX_DCDR = $╝ = '╝'
$CH_BOX_DSH  = $═ = '═'
$CH_BOX_DSV  = $║ = '║'

$CH_BOX_DJU  = $╩ = '╩'
$CH_BOX_DJD  = $╦ = '╦'
$CH_BOX_DJL  = $╣ = '╣'
$CH_BOX_DJR  = $╠ = '╠'
$CH_BOX_DJ   = $╬ = '╬'

class SpecialChars
  def SpecialChars.boxChars(text,type)
    throw "Invalid type, use :single or :double" unless type != :single or type != :double
    text = text.gsub(/[┌╔]/, {:single => '┌', :double => '╔'}[type])
    text = text.gsub(/[┐╗]/, {:single => '┐', :double => '╗'}[type])
    text = text.gsub(/[└╚]/, {:single => '└', :double => '╚'}[type])
    text = text.gsub(/[┘╝]/, {:single => '┘', :double => '╝'}[type])
    text = text.gsub(/[─═]/, {:single => '─', :double => '═'}[type])
    text = text.gsub(/[│║]/, {:single => '│', :double => '║'}[type])
    text = text.gsub(/[┴╩]/, {:single => '┴', :double => '╩'}[type])
    text = text.gsub(/[┬╦]/, {:single => '┬', :double => '╦'}[type])
    text = text.gsub(/[┤╣]/, {:single => '┤', :double => '╣'}[type])
    text = text.gsub(/[├╠]/, {:single => '├', :double => '╠'}[type])
    text = text.gsub(/[┼╬]/, {:single => '┼', :double => '╬'}[type])
  end
end

# ┌┐└┘─│┴┬┤├┼╔╗╚╝═║╦╣╠╩╬
#lol