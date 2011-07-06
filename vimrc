set nocompatible
set scrolloff=2
set nowrap
set wildmenu
set iskeyword+=?,!
set backspace=2
set background=dark
filetype plugin indent on
syntax on
set ruler
set incsearch
set ignorecase
set et
set sw=2
set smarttab
set number
noremap Y y$
set list
set lcs=tab:>>   "show tabs
set lcs+=trail:. "show trailing spaces
set pastetoggle=<F11>
set mouse=a

" highlight less files
"

if bufname("%") =~ ".less"
  set ft=css
end

noremap Q @q

function! BDD(args)
 if bufname("%") =~ "test.rb"
   call RunTest(a:args)
 elseif bufname("%") =~ ".scala"
   call RunSBTTest()
 elseif bufname("%") =~ ".feature"
   call RunCucumber()
 elseif bufname("%") =~ "spec.rb"
   call RunSpec(a:args)
 elseif bufname("%") =~ "spec.js"
   call RunJavascriptSpec(a:args)
 else
   echo "don't know how to BDD this file"
 end
endfunction

function! RunTest(args)
  let cursor = matchstr(a:args, '\d\+')
  if cursor
    while !exists("cmd") && cursor != 1
      if match(getline(cursor), 'def test') >= 0
        let cmd = ":! ruby % -vv -n ". matchstr(getline(cursor), "test_[a-zA-Z_]*")
      else
        let cursor -= 1
      end
    endwhile
  end
  if !exists("cmd")
    let cmd = ":! ruby % -vv"
  end
  execute cmd
endfunction

function! RunJavascriptSpec(args)
  execute ":!rake jasmine:ci"
endfunction

function! RunSpec(args)
  if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
    let spec = b:rails_root . "/script/spec"
  else
    let spec = "rspec"

  end
  let cmd = ":! " . spec . " % -cfn " . a:args
  execute cmd
endfunction

function! RunCucumber()
  if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
    let cuke = b:rails_root . "/script/cucumber"
  else
    let cuke = "bundle exec cucumber features"
  end
  let cmd = ":! " . cuke . " --format=pretty  %"
  execute cmd
endfunction

function! RunSBTTest()
  execute ":! java -jar ~/sbt-launcher-0.5.5.jar test"
endfunction

function Bar(type, msg)
  hi GreenBar term=reverse ctermfg=white ctermbg=green guifg=white guibg=green
  hi RedBar term=reverse ctermfg=white ctermbg=red guifg=white guibg=red
  if a:type == "red"
    echohl RedBar
  else
    echohl GreenBar
  endif
  echon a:msg repeat(" ", &columns - strlen(a:msg) - 1)
  echohl None
endfunction

map !s :call BDD("-l " . <C-r>=line('.')<CR>)
map !S :call BDD("")

map ;j :JSLintLight<CR>
map ;J :JSLintClear<CR>

map !b :%s/\s\+$//g<CR>
map !f :FufFile**/<CR>

" Setup git stuff
set laststatus=2
