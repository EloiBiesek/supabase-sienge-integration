# SUPABASE-SIENGE

Repositório para integração entre sistemas Sienge e Supabase.

## 📁 Estrutura do Repositório

### `/scripts-antigos/`
Contém todos os scripts Python originais e dados de desenvolvimento:

**Scripts de Teste e API:**
- `test_sienge_api.py` - Testes básicos da API Sienge
- `test_api_bills_comprehensive.py` - Testes abrangentes de bills/faturas
- `test_bill_debt_api.py` - Testes da API de débitos
- `test_bill_debt_expanded.py` - Versão expandida dos testes de débitos

**Scripts de Coleta de Dados:**
- `get_bills_historical_dates.py` - Coleta dados históricos de faturas
- `get_bills_working_period.py` - Coleta dados do período ativo
- `get_purchase_orders.py` - Coleta ordens de compra
- `find_accounts_receivable_api.py` - Busca contas a receber

**Scripts de População de Dados:**
- `populate_bills_data.py` - População inicial de dados de faturas
- `populate_bills_final.py` - Versão final da população de dados
- `populate_bills_supabase_mcp.py` - População usando MCP do Supabase
- `process_real_data.py` - Processamento de dados reais

**Dados de Teste:**
- `working_endpoints.json` - Endpoints funcionais da API
- `bill_debt_sample_data.json` - Dados de exemplo de débitos
- `bills_today.json` - Dados de faturas do dia

### `/documentos-analise/`
Contém documentos de análise, estudos e documentação técnica:

- `MCP_Analysis_Document.md` - Análise completa dos MCPs disponíveis
- *(Futuros documentos de análise serão adicionados aqui)*

## 🚀 Como Usar

1. **Scripts Antigos**: Consulte a pasta `scripts-antigos/` para referência histórica e reutilização de código
2. **Documentação**: Consulte `documentos-analise/` para entender as ferramentas e metodologias disponíveis
3. **Novos Desenvolvimentos**: Crie novos arquivos na raiz ou em subpastas específicas conforme necessário

## 🛠️ Tecnologias

- **Python**: Scripts de integração e processamento
- **Supabase**: Banco de dados e backend
- **Sienge API**: Sistema ERP fonte
- **MCPs**: Model Context Protocols para automação

## 📋 Próximos Passos

- Desenvolvimento de novos scripts baseados na análise dos MCPs
- Integração automatizada usando Supabase MCP
- Criação de workflows de CI/CD

---

*Repositório organizado para facilitar navegação e desenvolvimento futuro.* 