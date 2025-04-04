//Project: Face of Melinda 

SetErrorMode(2)

SetWindowTitle("Run Melinda, Run!" )
SetWindowSize( 1050, 675, 0 )
SetWindowAllowResize( 1 ) 

SetDisplayAspect ( 4.0 / 3.0 )
SetVirtualResolution( 1050, 675 ) 
SetOrientationAllowed( 1, 1, 1, 1 ) 
SetSyncRate( 60, 0 ) 


//Variaveis globais
global MelhorPonto as integer = 0
//-------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------Funções------------------------------------------------------------------

//SetandoAsSprites
function setaSprites(ceu, Fmont, backG, chao, tree, fogo, tenda)
			SetSpritePosition(ceu, 0, 0)
			setspritesize(ceu, 1190,980)
			
			SetSpritePosition(Fmont, 840, 200)
			setspritesize(Fmont, 700,500)
			
			SetSpritePosition(backG, -10, 300)
			setspritesize(backG, 1150,400)
			
						
			SetSpritePosition(chao, 0, 135)
			setspritesize(chao, 1150,550)
			
			SetSpritePosition(tree, -10, 300)
		    setspritesize(tree, 1150,350)
		   
		    SetSpritePosition ( fogo, 95, 620 ) 
		    SetSpriteSize ( fogo, 50, -20 )
			
			SetSpritePosition ( tenda, 200, 522 )
			SetSpriteSize ( tenda, 210, 150)
		    
		    AddSpriteAnimationFrame ( fogo, LoadImage ( "fogo1.png" ) )
			AddSpriteAnimationFrame ( fogo, LoadImage ( "fogo2.png" ) )
			AddSpriteAnimationFrame ( fogo, LoadImage ( "fogo3.png" ) )
			AddSpriteAnimationFrame ( fogo, LoadImage ( "fogo4.png" ) )
			AddSpriteAnimationFrame ( fogo, LoadImage ( "fogo5.png" ) )
			
					PlaySprite ( fogo, 10, 1, 1, 5)
endfunction 

//Controle do jogador
function controles(jogador)
	//Area de controles
       controleX# = GetJoystickX (  ) 
              x# = GetSpriteX ( jogador )
              SetSpritePosition (jogador, GetSpriteX(jogador)+(controleX#/1), GetSpriteY( jogador ))
  
endfunction

//Limites da Tela
function limites(jogador)
	//Area de limites
              if(GetSpriteX(jogador) < 0)
				  SetSpritePosition(jogador, 0, getspritey(jogador))
			  endif
			  if(GetSpriteX(jogador) > 250)
				  SetSpritePosition(jogador, 250, getspritey(jogador))
			  endif
			  if(GetSpriteY(jogador) < 385)
				  SetSpritePosition(jogador, GetSpriteX(jogador), 385)
			  endif
			  if(GetSpriteY(jogador) > 585)
				  SetSpritePosition(jogador, getspritex(jogador), 585)
			  endif
endfunction

//Verificando Colisao e setando pixels de invecibilidade
function colisao(jogador, arvore, reinicio, reinicie, restart, vida, passaro)
	if(GetSpriteCollision(jogador, arvore) and getspritey(jogador) > 550 or GetSpriteCollision(jogador, passaro) and GetSpriteX(jogador) < getspritex(passaro) -10)
		vidas = vidas - 1
		geraVida = 0
		reinicio = reinicio + 1
		if(vidas > 0)
			if(reinicio = 1)
				
				font = LoadFont("29Makina.ttf")
				
				SetSpriteSize(restart, 130, 130)
				SetSpritePosition(restart, 425, 255)
	
				SetTextPosition(reinicie, 165,410)
				SetTextSize(reinicie, 55)
				SetTextFont(reinicie, font)
		    crash = LoadSound("crash.wav")
			PlaySound ( crash, 35,0 )
			endif
			//Morte
			else
				reinicio = 5
		endif
	endif
	//Aumentando vida
	if(GetSpriteCollision(jogador, vida))
		vidas = vidas + 1
		    pegavida = LoadSound("pegavida.wav")
			PlaySound ( pegavida, 35,0 )
		SetSpritePosition(vida, getspritex(vida) + 10000,600)
	endif
endfunction reinicio



//----------------------------------------------------------------------------------------------------
//------------------------------------------Rotinas---------------------------------------------------
menu:
	global reinicio as integer = 0
	global vidas as integer = 3
	global gerador as integer = 1
    musica = LoadSound("sleeping_tree.wav")
	  PlaySound ( musica, 35,1 )
	  font = LoadFont("29Makina.ttf")

		    SetDefaultWrapU(1)
		    SetVSync(1)
		    
		 //Criando sprites do menu
		    //Planos de fundo
		    ceu = CreateSprite(LoadImage("ceu.png"))
			Fmont = CreateSprite(LoadImage("Fmontanha.png"))			
			backG = CreateSprite(LoadImage("montanhas.png"))
			chao = CreateSprite(LoadImage("chao.png"))	
			tree = CreateSprite(LoadImage("treee.png"))
		    //Fogo e tenda
			fogo = CreateSprite(LoadImage("fogo1.png"))
			tenda = CreateSprite(LoadImage("tent.png"))
	
			//Chamando funcao que aplica as sprites
			setaSprites(ceu, Fmont,  backG, chao, tree, fogo, tenda)

				//Area de texto
				MenuP = CreateSprite(LoadImage("logo.png"))
				SetSpritePosition(MenuP,340,50)
				SetSpriteVisible(MenuP,1)
				SetSpriteDepth(MenuP,1)
		
				start = CreateText("Start")
				exitT = CreateText("Exit")
				controles = CreateText("Pular ,space,  Reposionamento ,A D,")
				Pontu = CreateText("Melhor Pontuacao")
		
				SetTextPosition(start,450,285)
				SetTextPosition(exitT,450,330)
				SetTextPosition(controles, 150, 555)
				SetTextSize(controles, 55)
				SetTextPosition(Pontu, 0, -10)
				SetTextSize(Pontu, 55)
		
				SetTextFont(start, font)
				SetTextFont(exitT, font)
				SetTextFont(controles, font)
				SetTextFont(Pontu, font)
	
do	
	//Parallaxe
		cscroll# = cscroll#+0.0003
		SetSpriteUVOffset(ceu, cscroll#,0)
		Print("               :")
		Print(MelhorPonto)
		
	if GetTextHitTest(start,GetPointerX(),GetPointerY())
		SetTextSize(start,55)
		if GetPointerPressed() = 1
			SetTextPosition(start,-1500,-1500)
			SetTextPosition(exitT,-1500,-1500)
			SetTextPosition(controles, -1500, -1500)
				SetTextSize(Pontu, 45)
				SetTextPosition(Pontu, 0, 66)
				
				//flag
				inicio = 1
				
				DeleteSound(musica)
			gosub main
		endif
		else
			SetTextSize(start,50)		
	endif
	if GetTextExists(exitT)
		if GetTextHitTest(exitT,GetPointerX(),GetPointerY())
			SetTextSize(exitT,55)	
			if GetPointerPressed() = 1
				end
			endif
			else
			SetTextSize(exitT,50)
		endif
	endif
	Sync()
loop

main:

if(inicio = 1)
//Area de telas
SetDefaultWrapU(1)
SetVSync(1)
				
 musica = LoadSound("OIMSWS.wav")
 PlaySound ( musica, 25,1 )

 Ponto = CreateText("Pontos")
 SetTextFont(Ponto, font)
 SetTextSize(Ponto, 53)
 SetTextPosition(Ponto, 0, -10)
		
		
//Player
jogador = CreateSprite(LoadImage("protaRun1.png"))
SetSpriteSize ( jogador, 56, 90 )
SetSpritePosition ( jogador, 50, 600 )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaRun1.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaRun2.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaRun3.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaRun4.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaRun5.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaRun6.png" ) )
			
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao1.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao2.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao3.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao4.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao5.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao6.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao7.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao8.png" ) )
AddSpriteAnimationFrame ( jogador, LoadImage ( "protaMao9.png" ) )
			
arvore = CreateSprite(LoadImage("TreeScary.png"))
SetSpriteSize ( arvore, 80, 100 )
SetSpritePosition ( arvore, 1150, 574 )

passaro = CreateSprite(LoadImage("pato1.png"))
AddSpriteAnimationFrame ( passaro, LoadImage ( "pato2.png" ) )
AddSpriteAnimationFrame ( passaro, LoadImage ( "pato3.png" ) )
AddSpriteAnimationFrame ( passaro, LoadImage ( "pato4.png" ) )
SetSpriteSize ( passaro, 100, 100 )
SetSpritePosition ( passaro, 1500, 400 )
PlaySprite(passaro)

vida = CreateSprite(LoadImage("vida.png"))
SetSpritePosition(vida,4300,600)
SetSpriteSize ( vida, 53, -1 )
	    	 
												
//Variaveis
pontos = 0
i = 100
puloVel = 6
velocidade = 6
velocidadePasa = 10

//flags
pulo = 0
inicio = 0

endif
do

//Inicializando sprites especificas utilizando uma flag. Para evitar criar as mesmas sprites
if(gerador = 1)
	restart = CreateSprite(LoadImage("restart.png"))
	reinicie = CreateText("Passe o mouse no simb. para continuar")
	SetSpritePosition (restart, -1550, 600 )
	SetTextPosition (reinicie, -1250, 600 )
	gerador = 0
endif


if (reinicio = 0)
//Parallaxes
			cscroll# = cscroll#+0.0001 
			SetSpriteUVOffset(ceu, cscroll#,0)
		
		 	SetSpritePosition( Fmont, GetspriteX(Fmont)-0.3, GetSpriteY(Fmont))
				if(GetSpriteX(Fmont) < -600)
					SetSpritePosition(Fmont, 1000, GetSpriteY(Fmont))
				endif
		
			xscroll# = xscroll#+0.005 
			SetSpriteUVOffset(backG, xscroll#,0)
			
			ascroll# = ascroll#+0.005 
			SetSpriteUVOffset(tree, ascroll#,0)
		
			ccscroll# = ccscroll#+0.005
			SetSpriteUVOffset(chao, ccscroll#,0)

			SetSpritePosition( fogo, GetspriteX(fogo)-4, GetSpriteY(fogo))
			SetSpritePosition( tenda, GetspriteX(tenda)-4, GetSpriteY(tenda))
			SetSpritePosition( MenuP, GetspriteX(MenuP)-2, GetSpriteY(MenuP))
			

//------------------------------------------------------------------------------------------------------------------------------
	 //Area de controle do jogo
	 
	 //Controle de pontos
	 if(i = 0 and pontos < 20)
		pontos = pontos + 1
		i = 70
	 endif
	  if(i = 0 and pontos >= 20)
		pontos = pontos + 2
		i = 60
	 endif
	 	 if(i = 0 and pontos => 60)
		pontos = pontos + 3
		i = 50
	 endif
	 	 if(i = 0 and pontos >= 100)
		pontos = pontos + 4
		i = 40
	 endif
	 
	 
	 //Controle de dificuldade
	 if(pontos < 20)
		velocidade = 6
		velocidadePasa = 11
	 endif
	 if(pontos > 20 and pontos < 60)
		velocidade = 8
		velocidadePasa = 13
	 endif
	  if(pontos > 60 and pontos < 100)
		velocidade = 10
		velocidadePasa = 17
	 endif
	  if(pontos > 100)
		velocidade = 12
		velocidadePasa = 16
	 endif
	 
	 
//------------------------------------------------------------------------------------------------------------------------------
		//Pulo. Nao deu para ficar em funcao / Limitando para pular apenas quando tiver no chao
		if(GetRawKeyPressed(32) and GetSpriteY(jogador) > 570)
			pulo = 1
			PlaySprite ( jogador, 10, 1, 8, 15 )
		endif
		if (pulo = 1)
			SetSpritePosition( jogador, GetspriteX(jogador)+3, GetSpriteY(jogador)-puloVel-4)
				if(GetSpriteY(jogador) < 400 )
					 StopSprite(jogador)
					pulo = 0
				endif
		endif
		//Descida
		if(pulo = 0)
				SetSpritePosition( jogador, GetspriteX(jogador), GetSpriteY(jogador)+puloVel+1)
				 if (GetSpritePlaying( jogador ) = 0 )
					PlaySprite ( jogador, 12, 1, 1, 6 )
				  endif	
		endif
//------------------------------------------------------------------------------------------------------------------------------


	//Chamaeda de funcoes
		//Chamada da funcao de movimento
		controles(jogador)
		//Chaamada da funcao de limites
		limites(jogador)
		//Verificando colisao
		reinicio = colisao(jogador, arvore, reinicio, reinicie, restart, vida, passaro)
		
//---------------------------------------------------------------------------------------------------------------------------------
		
	//Area de geração
			SetSpritePosition( arvore, GetspriteX(arvore)-velocidade, GetSpriteY(arvore))
				if(GetSpriteX(arvore) < -600)
					SetSpritePosition(arvore, 1000, GetSpriteY(arvore))
				endif
			SetSpritePosition( passaro, GetspriteX(passaro)-velocidadePasa, GetSpriteY(passaro))
				if(GetSpriteX(passaro) < -700)
					SetSpritePosition(passaro, 1300, GetSpriteY(passaro))
				endif
			
			SetSpritePosition( vida, GetspriteX(vida)-velocidade, GetSpriteY(vida))

//------------------------------------------------------------------------------------------------------------------------------\

		//Prints na tela
		Print("     :") 
		Print(pontos)
		Print("            :")
		Print(MelhorPonto)
		Print("Vidas: ")
		Print(vidas)
		i = i - 1
  //Print( ScreenFPS() )
    Sync()
endif

//===============================================================================================================================
			//Restart
			if(reinicio = 1)
					if(GetSpriteHitTest(restart,GetPointerX(),GetPointerY()))
							SetSpritePosition (jogador, 50, 600 )
							
							//Resetando as flags
							reinicio = 0	
							pulo = 0
							
							PlaySprite ( jogador, 12, 1, 1, 6 )
							deletesprite(restart)
							deletetext(reinicie)
							SetSpritePosition(arvore, -1000, 574)
							if(pontos < 100)
								SetSpritePosition(passaro, -1000, 400)
							
							else
								SetSpritePosition(passaro, 1500, 400)
							endif
							gerador = 1
						gosub main
					endif
				endif
			
			//Finalizando o jogo apos perder as vidas
			if(reinicio = 5)
				
				if(pontos  > MelhorPonto)
					MelhorPonto = pontos
				endif
				deletesprite(jogador)
				deletesprite(arvore)
				deletetext(Pontu)
				DeleteText(Ponto)
				deletesprite(MenuP)
				deletesprite(vida)
				deletesound(musica)

				gosub menu
			endif
loop
