# Acervo — publicação online

## Estrutura atual

- `public/`: aplicação web.
- `netlify/functions/data.js`: API usada pela aplicação para sincronização.
- `supabase/setup.sql`: estrutura do banco compartilhado.
- `netlify.toml`: configuração de publicação no Netlify.

## Publicação no Netlify

O repositório está preparado para Continuous Deployment. No Netlify, use **Add new project → Import an existing project → GitHub** e selecione `suelendelima96978-sta/cobranca`.

A publicação usa:
- Publish directory: `public`
- Functions directory: `netlify/functions`
- API: `/api/data`

Depois da criação do site, configure no Netlify, em **Project configuration → Environment variables**, estas variáveis:

`SUPABASE_URL`
URL do projeto Supabase.

`SUPABASE_SECRET_KEY`
Chave privada do Supabase. Nunca coloque esta chave no código ou no GitHub.

`SHARE_TOKEN`
Código secreto que será usado no link de acesso ao Acervo.

No Supabase, execute primeiro `supabase/setup.sql`.

Depois que as variáveis estiverem configuradas, faça um novo deploy. O Netlify continuará publicando automaticamente a cada alteração enviada para a branch `main`.

## Manutenção

As alterações futuras podem ser feitas diretamente no repositório. O objetivo é manter o código, a publicação e o banco separados: GitHub guarda o código; Netlify publica a aplicação e executa a função; Supabase guarda os registros compartilhados.
