classdef Result
    % Result Contiene el candidato.
    %       
    % ---------------------------------------------------------------------

    properties
        % Query
        Query
        
        % Candidatos
        Candidate
    end
     
    methods
        
        function obj = Result(query)
            % obj = Candidate(index, value)
            % Table Constructor de la clase.
            %            
            % Argumentos:
            %  - index: Índice del candidato.
            %  - value: Valoar del desciptor asociado.
            %  - time : Instante de tiempo.
            %  - freq : Valor de frecuencia.
            % -------------------------------------------------------------
            if nargin > 0
                obj.Query = query;
            end
        end
     
    end
    
end