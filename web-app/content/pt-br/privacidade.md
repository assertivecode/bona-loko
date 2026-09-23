---
id: privacy_policy
title: "Política de Privacidade & Soberania de Dados"
slug: "privacidade"
last_updated: "2026-09-24"
summary: "Entenda como a Bona Loko respeita a sua privacidade com zero coleta direta de dados e como serviços de infraestrutura como Cloudflare e Google tratam informações técnicas genéricas."
---

# Política de Privacidade & Soberania de Dados

> *"A verdadeira transformação pessoal requer serenidade mental e independência inegociável. A Bona Loko foi estruturada desde o primeiro princípio para respeitar a atenção humana, a reflexão privada e a soberania individual."*

**Data de Vigência:** 24 de setembro de 2026  
**Aplicabilidade:** Aplicação Web Bona Loko ([bonaloko.com](https://bonaloko.com)) & Aplicativo Mobile Bona Loko.

---

## 1. Compromisso Fundamental: Zero Coleta Direta de Dados

A Bona Loko opera sob uma **arquitetura de conhecimento zero (zero-knowledge) e prioritariamente local (local-first)**. Seja utilizando a plataforma web ou o aplicativo mobile:

- **Não coletamos, solicitamos ou armazenamos suas informações pessoais.**
- **Sem cadastro de conta:** Você não precisa fornecer nome, e-mail, senha, telefone ou login social para utilizar a plataforma.
- **Sem banco de dados centralizado de usuários:** A Bona Loko não opera servidores em nuvem ou bancos de dados remotos para armazenar perfis, notas pessoais, pontuações de vida ou hábitos.

### Armazenamento Exclusivamente Local
- **Aplicação Web:** Todas as avaliações de áreas da vida, notas de reflexão, pontuações de equilíbrio e preferências visuais permanecem salvas localmente no seu navegador por meio de HTML5 `localStorage` e cookies estritamente voltados à escolha de idioma (`bona_loko_locale`).
- **Aplicativo Mobile:** Todas as sequências de hábitos, motivos de gratidão, rotinas de atividades físicas e lançamentos de gestão financeira são gravados unicamente no banco de dados SQLite local (via Drift) do seu aparelho celular. Nada é enviado para servidores externos.

---

## 2. Infraestrutura de Terceiros & Serviços Analíticos

Embora a Bona Loko não colete dados diretamente, o acesso à aplicação web envolve a comunicação com redes de distribuição de conteúdo (CDN) e ferramentas de medição. Acreditamos na transparência absoluta sobre o papel desses parceiros.

### Resumo: Informações Genéricas vs. Informações Pessoais

| Serviço | Função Principal | Tipo de Informação | Classificação | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| **Cloudflare** | Hospedagem de borda, CDN & Proteção DDoS | Cabeçalhos técnicos de rede, endereço IP, user-agent, cifra TLS, URL requisitada, data/hora | **Informação Técnica Genérica** *(IP tratado de forma pseudônima na camada de rede)* | Entregar arquivos com rapidez global, mitigar ataques cibernéticos e bloquear robôs |
| **Google Analytics (GA4)** | Métricas Agregadas de Acesso | Visualizações de páginas, tempo de sessão, tipo de dispositivo, navegador, região/cidade aproximada, origem do acesso | **Métricas Agregadas Genéricas** *(Sem identificadores pessoais)* | Compreender quais guias são úteis, monitorar estabilidade e corrigir links quebrados |
| **Google Search** | Indexação em Mecanismo de Busca | Termos pesquisados e cliques nos resultados de busca do Google | **Métricas Externas Genéricas** | Permitir que pessoas encontrem orientações de equilíbrio de vida no buscador |

---

## 3. Hospedagem & Entrega de Borda via Cloudflare

A aplicação web é hospedada e distribuída globalmente pela rede de borda **Cloudflare Pages & Workers** (Cloudflare, Inc.).

### Quais informações são processadas:
Ao solicitar uma página em nosso site, a rede da Cloudflare recebe:
- **Endereço IP:** Necessário tecnicamente para rotear os pacotes da página até o seu dispositivo.
- **Cabeçalhos de Requisição Técnica:** Sistema operacional, navegador (user-agent), URL requisitada, idioma do navegador e dimensões aproximadas de tela.
- **Telemetria de Segurança:** Padrões de tráfego para detecção de ataques de negação de serviço (DDoS) e bots maliciosos.

### Distinção entre Informações Pessoais e Genéricas:
- **Dados Genéricos:** Versões de navegadores, tempo de resposta, proporção de cache e sistemas operacionais são estritamente técnicos e impessoais.
- **Endereços IP:** Embora os endereços IP sejam classificados como dados pessoais pseudônimos sob regulações como LGPD e GDPR, a Cloudflare os utiliza unicamente para roteamento seguro e blindagem cibernética. A Cloudflare não comercializa esses dados, e a Bona Loko não possui meios de associar nenhum endereço IP à identidade civil de um usuário.

Para detalhes sobre conformidade, consulte a [Política de Privacidade da Cloudflare](https://www.cloudflare.com/privacypolicy/).

---

## 4. Google Analytics & Google Search

A aplicação web utiliza o **Google Analytics (GA4)** para avaliar o engajamento e aprimorar o conteúdo didático da plataforma.

### Quais informações são coletadas:
O Google Analytics coleta dados agregados e impessoais de interação:
- **Navegação no Site:** Páginas acessadas, tempo despendido, marcos de rolagem e cliques em links externos.
- **Ambiente de Acesso:** Categoria do dispositivo (celular, computador, tablet), resolução de tela, navegador e sistema operacional.
- **Localização Aproximada:** País e cidade aproximada derivados do mascaramento automático de IP.

### Distinção entre Informações Pessoais e Genéricas:
- **Eritamente Genérico e Anonimizado:** O GA4 mascara automaticamente os endereços IP por padrão, não registrando nem armazenando IPs individuais.
- **Zero Dados Sensíveis Transmitidos:** A Bona Loko nunca envia notas, notas reflexivas, dados financeiros, hábitos ou pontuações de vida para o Google Analytics.
- **Sem Perfil Publicitário:** Não ativamos o Google Signals, recursos de remarketing ou identificadores de publicidade personalizada.

### Google Search (Busca Google)
Nossas páginas são indexadas publicamente na Pesquisa Google. As consultas digitadas no buscador são regidas pela [Política de Privacidade do Google](https://policies.google.com/privacy). A Bona Loko recebe apenas métricas estatísticas de alto nível (como total de impressões e cliques por página) pelo painel do Google Search Console.

---

## 5. Cookies e Gestão de Armazenamento Local

A Bona Loko utiliza o mínimo estritamente necessário de armazenamento no seu navegador:

1. **Cookie Funcional (`bona_loko_locale`):** Memoriza o idioma preferido (`pt-BR`, `en-US` ou `eo`) para carregar o site no seu idioma.
2. **Armazenamento Local (`localStorage`):** Guarda suas respostas e notas da Roda da Vida diretamente no seu navegador.
3. **Cookies Analíticos (`_ga`, `_ga_*`):** Emitidos pelo Google Analytics para distinguir sessões anônimas ao longo das visitas.

### Como você pode gerenciar:
- **Limpeza no Navegador:** Você pode limpar cookies e dados de sites a qualquer instante nas configurações do seu navegador. Isso apagará imediatamente os dados salvos localmente.
- **Não Rastrear (Do Not Track / GPC):** Você pode habilitar os sinais de controle de privacidade global em seu navegador.
- **Bloqueio de Analytics:** É possível instalar a extensão oficial de [Desativação do Google Analytics](https://tools.google.com/dlpage/gaoptout) ou utilizar bloqueadores de rastreadores focados em privacidade.

---

## 6. Privacidade Específica no Aplicativo Mobile

O aplicativo mobile da Bona Loko (Construtor de Hábitos) adota uma postura ainda mais estrita:
- **100% Offline:** Todas as informações (hábitos, prioridades de vida, anotações de gratidão, treinos e despesas/receitas financeiras) residem exclusivamente no banco SQLite do seu celular.
- **Sem SDKs Publicitários ou Rastreadores:** O aplicativo não contém SDKs de anúncios, ferramentas de telemetria oculta ou rastreamento de geolocalização em segundo plano.
- **Exclusão Completa:** Excluir um hábito, uma transação ou desinstalar o aplicativo remove imediatamente e para sempre todos os dados da memória do aparelho.

---

## 7. Privacidade de Crianças e Menores (LGPD & COPPA)

A Bona Loko não solicita nem coleta conscientemente dados de crianças ou adolescentes. Como o sistema não exige cadastro e armazena informações apenas localmente no próprio aparelho do usuário, não há guarda de registros de menores em nossos servidores.

---

## 8. Atualizações desta Política

Conforme a plataforma evoluir, este documento poderá ser atualizado para refletir melhorias técnicas ou adequações legais. Qualquer revisão será publicada nesta mesma página com a respectiva indicação da "Data de Vigência".

---

## 9. Contato & Governança Aberta

A Bona Loko é desenvolvida de forma aberta e pautada em princípios morais. Se você tiver dúvidas sobre nossa arquitetura de privacidade, sinta-se convidado a inspecionar nosso código-fonte aberto ou entrar em contato:

- **Repositório de Código Aberto:** [github.com/assertivecode/bona-loko](https://github.com/assertivecode/bona-loko)
- **Constituição Moral da Plataforma:** [FOUNDATION.md](https://github.com/assertivecode/bona-loko/blob/main/FOUNDATION.md)
