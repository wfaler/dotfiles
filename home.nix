{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = [
    pkgs.kubectl
    pkgs.kubeval
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.kustomize 
    pkgs.zsh
    pkgs.oh-my-zsh
    pkgs.cloc
    pkgs.direnv
    pkgs.terraform_1_0_0
    pkgs.packer
    pkgs.git-secret
    pkgs.google-cloud-sdk
    pkgs.awscli
    pkgs.go
    pkgs.protoc-gen-go
    pkgs.cloc
    pkgs.google-cloud-sdk
    pkgs.ripgrep
  ];

  programs.tmux = {
    enable = true;
    terminal = "screen";
    shell = "$HOME/.nix-profile/bin/zsh";
    extraConfig = ''
      source-file "$HOME/.tmux-themepack/powerline/default/cyan.tmuxtheme"
   '';
  };

  programs.git = {
    enable = true;
    userName = "Wille Faler";
    userEmail = "wille.faler@gmail.com";
  };
  
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.1.0";
          sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
        };
      }
    ];
    sessionVariables = {
    #  NIX_PROFILES=/nix/var/nix/profiles/default /home/wfaler/.nix-profile
    # export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
      NIX_PATH = "$HOME/.nix-defexpr/channels";
      GOPATH = "$HOME/apps/go";
      GOBIN = "$HOME/apps/go/bin";
      PATH = "$HOME/.nix-profile/bin:$GOPATH/bin:$HOME/apps/bin:$PATH";
      EDITOR = "nvim";
      NIXPKGS_ALLOW_UNFREE = 1;
    };
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      nvim = "nvim";
    };
    initExtra = ''mkdir -p $HOME/apps/go/bin && . $HOME/.nix-profile/etc/profile.d/nix.sh && mkdir -p $HOME/.config/nvim
if [ ! -d $HOME/.tmux-themepack ]; then
   git clone https://github.com/jimeh/tmux-themepack.git $HOME/.tmux-themepack
fi
cat << EOF > $HOME/.config/nvim/coc-settings.json
{
  "languageserver": {
    "golang": {
      "command": "gopls",
      "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
      "filetypes": ["go"]
    }
  }
}

EOF
    '';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" "kubectl" ];
    theme = "agnoster";
  };


    
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-packer
      popup-nvim
   #   plenary-nvim
   #   telescope-nvim
   #   telescope-fzy-native-nvim
      coc-yaml
      coc-json
      coc-html
      coc-git
      coc-css
      coc-tslint
      coc-tsserver
      coc-pyright
      vim-airline
      vim-airline-themes
      nerdtree
      direnv-vim
      vim-nix
      vim-terraform
      python-mode
      vim-go
      coc-nvim
      coc-metals
    ];

	extraConfig = ''
:let mapleader = "-"
:set autoread
:set number
:set noexpandtab
:set copyindent
:set preserveindent
:set softtabstop=0
:set shiftwidth=4
:set tabstop=4
let g:airline#extensions#tabline#enabled = 1

function! s:update_git_status()
  let g:airline_section_b = "%{get(g:,\'coc_git_status\',\'\')}"
endfunction

let g:airline_section_b = "%{get(g:,\'coc_git_status\',\'\')}"


autocmd User CocGitStatusChange call s:update_git_status()

nnoremap bn <cmd>:bn<cr>
nnoremap bp <cmd>:bp<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Nerdtree mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
let g:go_def_mapping_enabled = 0


	'';
  }; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "codespace";
  home.homeDirectory = "/home/codespace";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
} 
