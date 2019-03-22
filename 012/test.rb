# encoding: utf-8

require 'universum'


TicTacToe = Contract.load( './tictactoe' )
pp TicTacToe

####
# setup test accounts
Account[ '0xaaaa' ]
Account[ '0xbbbb' ]


tx = Uni.send_transaction( from: '0xaaaa', data: [TicTacToe] )
tictactoe = tx.receipt.contract
pp tictactoe

Uni.send_transaction( from: '0xaaaa', to: tictactoe, data: [:create, '0xbbbb', '0xaaaa'])
pp tictactoe

# 1st move by 0xaaaaa
Uni.send_transaction( from: '0xaaaa', to: tictactoe, data: [:move, '0xbbbb', '0xaaaa', '0xaaaa', 0, 0])
pp tictactoe
# 1st move by 0xbbbb
Uni.send_transaction( from: '0xbbbb', to: tictactoe, data: [:move, '0xbbbb', '0xaaaa', '0xbbbb', 0, 1])
pp tictactoe
# 2nd move by 0xaaaa
Uni.send_transaction( from: '0xaaaa', to: tictactoe, data: [:move, '0xbbbb', '0xaaaa', '0xaaaa', 1, 1])
pp tictactoe
# 2nd move by 0xbbbb
Uni.send_transaction( from: '0xbbbb', to: tictactoe, data: [:move, '0xbbbb', '0xaaaa', '0xbbbb', 0, 2])
pp tictactoe
# 3rd move by 0xaaaa - WIN!
Uni.send_transaction( from: '0xaaaa', to: tictactoe, data: [:move, '0xbbbb', '0xaaaa', '0xaaaa', 2, 2])
pp tictactoe


###
# try restart
Uni.send_transaction( from: '0xaaaa', to: tictactoe, data: [:restart, '0xbbbb', '0xaaaa', '0xaaaa'])
pp tictactoe

###
# try cleanup
Uni.send_transaction( from: '0xaaaa', to: tictactoe, data: [:close, '0xbbbb', '0xaaaa'])
pp tictactoe

##
# try another game
Uni.send_transaction( from: '0xbbbb', to: tictactoe, data: [:create, '0xaaaa', '0xbbbb'])
pp tictactoe
