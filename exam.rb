require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/exam', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')
# <form action='indicate.cgi'> 〜 </form>の内部にある値を、indicate.rbに送信することができるようになる　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb') #追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
# Webrickのサーバを起動させる
server.start