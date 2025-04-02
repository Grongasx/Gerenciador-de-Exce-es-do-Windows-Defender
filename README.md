# Gerenciador de Exceções do Windows Defender

Este script PowerShell permite gerenciar facilmente as exceções do Windows Defender, especialmente para arquivos DLL.

## Funcionalidades

- Adicionar exceções para arquivos DLL no Windows Defender
- Listar todas as exceções existentes
- Interface interativa com menu de opções
- Verificação automática de privilégios de administrador
- Feedback visual do status das operações

## Requisitos

- Windows 10/11
- PowerShell 5.1 ou superior
- Privilégios de administrador

## Como usar

1. Clone ou baixe este repositório
2. Clique com o botão direito no arquivo `add_defender_exception.ps1`
3. Selecione "Executar com PowerShell como administrador"
4. Use o menu interativo para:
   - Adicionar novas exceções
   - Visualizar exceções existentes

## Menu de Opções

1. **Adicionar nova exceção**
   - Abre uma janela para selecionar o arquivo DLL
   - Adiciona o arquivo selecionado às exceções do Windows Defender
   - Verifica se a exceção foi adicionada com sucesso

2. **Listar exceções existentes**
   - Mostra todas as exceções configuradas no Windows Defender
   - Exibe o caminho completo de cada exceção
   - Mostra o total de exceções

3. **Sair**
   - Encerra o programa

## Notas de Segurança

- O script requer privilégios de administrador para funcionar
- Todas as operações são verificadas e validadas
- Feedback visual indica o sucesso ou falha das operações

## Contribuição

Sinta-se à vontade para contribuir com melhorias através de Pull Requests ou reportar problemas através de Issues. 