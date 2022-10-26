-- Table: public.endereco

-- DROP TABLE IF EXISTS public.endereco;

CREATE TABLE IF NOT EXISTS public.endereco
(
    idendereco bigint NOT NULL DEFAULT nextval('endereco_idendereco_seq'::regclass),
    idpessoa bigint NOT NULL,
    dscep character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT endereco_pk PRIMARY KEY (idendereco),
    CONSTRAINT endereco_fk_pessoa FOREIGN KEY (idpessoa)
        REFERENCES public.pessoa (idpessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.endereco
    OWNER to postgres;
-- Index: endereco_idpessoa

-- DROP INDEX IF EXISTS public.endereco_idpessoa;

CREATE INDEX IF NOT EXISTS endereco_idpessoa
    ON public.endereco USING btree
    (idpessoa ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: trg_bef_ins_end

-- DROP TRIGGER IF EXISTS trg_bef_ins_end ON public.endereco;

CREATE TRIGGER trg_bef_ins_end
    BEFORE INSERT
    ON public.endereco
    FOR EACH ROW
    EXECUTE FUNCTION public.func_supress_id_if0_end();
	
-- Table: public.endereco_integracao

-- DROP TABLE IF EXISTS public.endereco_integracao;

CREATE TABLE IF NOT EXISTS public.endereco_integracao
(
    idendereco bigint NOT NULL,
    dsuf character varying(50) COLLATE pg_catalog."default",
    nmcidade character varying(100) COLLATE pg_catalog."default",
    nmbairro character varying(50) COLLATE pg_catalog."default",
    nmlogradouro character varying(100) COLLATE pg_catalog."default",
    dscomplemento character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT enderecointegracao_pk PRIMARY KEY (idendereco),
    CONSTRAINT enderecointegracao_fk_endereco FOREIGN KEY (idendereco)
        REFERENCES public.endereco (idendereco) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.endereco_integracao
    OWNER to postgres;
	
-- Table: public.pessoa

-- DROP TABLE IF EXISTS public.pessoa;

CREATE TABLE IF NOT EXISTS public.pessoa
(
    idpessoa bigint NOT NULL DEFAULT nextval('pessoa_idpessoa_seq'::regclass),
    flnatureza smallint NOT NULL,
    dsdocumento character varying(20) COLLATE pg_catalog."default" NOT NULL,
    nmprimeiro character varying(100) COLLATE pg_catalog."default" NOT NULL,
    nmsegundo character varying(100) COLLATE pg_catalog."default" NOT NULL,
    dtregistro date,
    CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa),
    CONSTRAINT pessoa_unique_dsdocumento UNIQUE (dsdocumento),
    CONSTRAINT chieck_flnatureza CHECK (flnatureza = ANY (ARRAY[1, 2])) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pessoa
    OWNER to postgres;

-- Trigger: trg_bef_ins_pessoa

-- DROP TRIGGER IF EXISTS trg_bef_ins_pessoa ON public.pessoa;

CREATE TRIGGER trg_bef_ins_pessoa
    BEFORE INSERT
    ON public.pessoa
    FOR EACH ROW
    EXECUTE FUNCTION public.func_supress_id_if_0();