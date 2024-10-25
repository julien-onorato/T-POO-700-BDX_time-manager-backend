--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-1.pgdg22.04+1)
-- Dumped by pg_dump version 17.0 (Ubuntu 17.0-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: user_roles; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_roles AS ENUM (
    'admin',
    'super manager',
    'manager',
    'employee'
);


ALTER TYPE public.user_roles OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clock_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clock_periods (
    id bigint NOT NULL,
    clock_in timestamp(0) without time zone,
    clock_out timestamp(0) without time zone,
    user_id integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.clock_periods OWNER TO postgres;

--
-- Name: clock_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clock_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clock_periods_id_seq OWNER TO postgres;

--
-- Name: clock_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clock_periods_id_seq OWNED BY public.clock_periods.id;


--
-- Name: clocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clocks (
    id bigint NOT NULL,
    "time" timestamp(0) without time zone,
    status boolean DEFAULT false NOT NULL,
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.clocks OWNER TO postgres;

--
-- Name: clocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clocks_id_seq OWNER TO postgres;

--
-- Name: clocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clocks_id_seq OWNED BY public.clocks.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    team_name character varying(255) NOT NULL,
    manager_id integer NOT NULL,
    employee_ids integer[]
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teams_team_id_seq OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255),
    email character varying(255),
    password_hash character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    manager_id bigint,
    roles character varying(255)[] DEFAULT ARRAY[]::character varying[],
    role character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: workingtime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workingtime (
    id bigint NOT NULL,
    start timestamp(0) without time zone,
    "end" timestamp(0) without time zone,
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.workingtime OWNER TO postgres;

--
-- Name: workingtime_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.workingtime_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workingtime_id_seq OWNER TO postgres;

--
-- Name: workingtime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workingtime_id_seq OWNED BY public.workingtime.id;


--
-- Name: clock_periods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clock_periods ALTER COLUMN id SET DEFAULT nextval('public.clock_periods_id_seq'::regclass);


--
-- Name: clocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clocks ALTER COLUMN id SET DEFAULT nextval('public.clocks_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: workingtime id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workingtime ALTER COLUMN id SET DEFAULT nextval('public.workingtime_id_seq'::regclass);


--
-- Data for Name: clock_periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clock_periods (id, clock_in, clock_out, user_id, inserted_at, updated_at) FROM stdin;
1	2024-10-18 13:20:15	2024-10-18 13:20:19	8	2024-10-18 13:20:16	2024-10-18 13:20:19
2	2024-10-23 08:45:42	\N	8	2024-10-23 08:45:32	2024-10-23 08:45:32
\.


--
-- Data for Name: clocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clocks (id, "time", status, user_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20241007133418	2024-10-17 13:09:50
20241007133433	2024-10-17 13:09:51
20241007133445	2024-10-17 13:09:51
20241010084443	2024-10-17 13:09:51
20241013131819	2024-10-17 13:09:51
20241023105942	2024-10-23 12:28:39
20241024131949	2024-10-24 14:47:36
20241024144509	2024-10-24 14:47:36
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (team_id, team_name, manager_id, employee_ids) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, inserted_at, updated_at, manager_id, roles, role) FROM stdin;
51	testeur18	test18.login@example.com	$2b$12$Flmgk1atMidMu1u9TCRFHuSIHVuhT/..WlAr2zVCEneQ91T35fizO	2024-10-21 07:10:55	2024-10-21 07:10:55	\N	{}	admin
52	testeur19	test19.login@example.com	$2b$12$7EsK7Lz/UOJ7hikHBhLnC.Hc0nMMheK1bAWlgDLB3lKawXvu8qy/m	2024-10-23 07:49:33	2024-10-23 07:49:33	\N	{}	super manager
53	testeur20	test20.login@example.com	$2b$12$ejJQLJNwn0nNxno/YGMFeuuxnAFGHXvMueLiVFMCqQbbOq2xi5bNi	2024-10-23 08:12:30	2024-10-23 08:12:30	\N	{Admin}	manager
54	test24	test24@test.com	$2b$12$UpS2IlyWTSOTehxSQr3IDO..R4ehBkxROwDxUlv3alrbPakSu.bWW	2024-10-23 08:42:39	2024-10-23 14:03:53	\N	{}	employee
55	testeur21	test21.login@example.com	$2b$12$SlyBydOD7IXmtqBKBUFuVexew4HuLwCDFbE.jCfT9QEUvJYtr2.qu	2024-10-23 10:40:22	2024-10-23 14:37:40	\N	{}	user
3	bassem	bassem@example.com	$2b$12$X86hJxJb9kW/7L2.aPBYnOa2Fm6.5SXOXNm9wXuj.RuOeRvKbUznS	2024-10-17 13:17:50	2024-10-17 13:17:50	\N	{}	user
4	bassem	bassem@example.com	$2b$12$JBT5z.u0S9jArLIo2I8BJuzwMdZK5yVCFs.XZQ5LkfBA3CE93yT/2	2024-10-17 13:19:27	2024-10-17 13:19:27	\N	{}	super manager
5	bassem	bassem@example.com	$2b$12$QGLqSl8D9y5tKxxzznII5Od02Iiz7SGzRJ4pC.ekhU6DsxC6bqC0S	2024-10-17 13:19:46	2024-10-17 13:19:46	\N	{}	manager
6	bassem	bassem@example.com	$2b$12$lqVUksQ3D1lH3vgZLZElB.n6ceOhonBDIgMoHqG54YCNKwAqj7ocG	2024-10-17 13:23:23	2024-10-17 13:23:23	\N	{}	employee
7	bassem	bassem@example.com	$2b$12$a9RP2y2SsojeNscjQYq2KO5beTo02K.06xphipl6BGKIxBqTM9Ikq	2024-10-17 13:29:27	2024-10-17 13:29:27	\N	{}	user
8	bassem	bassem@example.com	$2b$12$wQb1bI4XJrtdISNuMZzOCe4kgbd4w5C9o66FDZTsNsNjYIH62JWf2	2024-10-17 13:32:23	2024-10-17 13:32:23	\N	{}	super manager
9	bassem	bassem@example.com	$2b$12$j3vaYQm1ATM0l2SsDeJYD.jOWN6pb8upJmOrMgFH39ma5FfkFCawG	2024-10-17 13:36:57	2024-10-17 13:36:57	\N	{}	manager
10	bassem	bassem@example.com	$2b$12$.NeS5qZIBDKsqX1Hnn9EVeyilCyUurvONRI3c0fSVXehKOZa8Y5Bm	2024-10-17 13:40:41	2024-10-17 13:40:41	\N	{}	employee
11	bassem	bassem@example.com	$2b$12$lX0vSVlsL1lEn1/AEQDYq.cI/REkuma.beaM9IMowTP3miwVT/eiS	2024-10-17 13:49:36	2024-10-17 13:49:36	\N	{}	user
12	bassem	bassem@example.com	$2b$12$xY49uRPwRLDTCd2KdJmFYecA1X9Kb2Y163MU7FPN77XhXCiX48G16	2024-10-17 13:55:27	2024-10-17 13:55:27	\N	{}	super manager
13	la radio	bassem.bassem@example.com	$2b$12$h0rlxF37XcrWd5cQDkTUbelMacTROShrwofdFAasdlZqy7p0/RmQC	2024-10-17 14:02:53	2024-10-17 14:02:53	\N	{}	manager
14	testeur	test.login@example.com	$2b$12$eWG24/YFZNsCMAg2bBv32O0M7ANgqiSketNRU4HrDksdW4ne1AX0K	2024-10-17 14:05:30	2024-10-17 14:05:30	\N	{}	employee
15	testeur	test.login@example.com	$2b$12$zqAKzcFV3NbBz99xAF7.0ukRDoaBla1aSN9BIrdzTHFQQ8Fd1pBAG	2024-10-17 14:16:40	2024-10-17 14:16:40	\N	{}	user
16	testeur2	test2.login@example.com	$2b$12$5JznSb2RXJJkUpfeDbVUw.IXYL4/aNNCLF2UbDrCypOpPKA0OPgBW	2024-10-17 14:18:23	2024-10-17 14:18:23	\N	{}	super manager
17	testeur2	test2.login@example.com	$2b$12$ENQZpHB0MMgkKa.HbyyDmO7X//ga8o0g.1cPlGcFEj5bpa/uz7qm.	2024-10-17 14:19:18	2024-10-17 14:19:18	\N	{}	manager
18	testeur2	test3.login@example.com	$2b$12$jJx0WerBf/nt0l7PSvkoGeSoJabO/D.JvBkI8cZK/oB7EuC54f/Pq	2024-10-17 14:21:41	2024-10-17 14:21:41	\N	{}	employee
19	testeur4	test4.login@example.com	$2b$12$AvwsBdR9jc8FlwMgfmlp2uooVeBAyHj5oJopE2II00HjEFdytmsru	2024-10-17 14:27:12	2024-10-17 14:27:12	\N	{}	user
20	testeur4	test4.login@example.com	$2b$12$WvSOIj20/lwL7/4SXMgNNOsdq/9LNaNLc9ihc4VunXHzoqytOK4Ee	2024-10-17 18:11:47	2024-10-17 18:11:47	\N	{}	super manager
21	testeur5	test5.login@example.com	$2b$12$RY1Pdr/qn3ipAAKzM.LNguWT14OiY3AKAQjWrsrHclhRliryC2jfe	2024-10-17 18:12:58	2024-10-17 18:12:58	\N	{}	manager
22	testeur6	test6.login@example.com	$2b$12$yhDHSNwfbPDqTnh1TavKfOqK9KZLYMUL4LxvB328cvUnrNGlf0Iku	2024-10-17 18:58:24	2024-10-17 18:58:24	\N	{}	employee
23	testeur7	test7.login@example.com	$2b$12$1CR4vc/MFvctVdRDZzEDjOHUpb1dN7ACAjuaSE7rcMDknlDK6W8zu	2024-10-17 19:24:51	2024-10-17 19:24:51	\N	{}	user
24	testeur9	test9.login@example.com	$2b$12$da5sxkXYuulpNrU5zjZQhePIKXbjdL38JFzGLlj2etCR2.tJ1bSC6	2024-10-17 19:25:23	2024-10-17 19:25:23	\N	{}	super manager
25	testeur9	test9.login@example.com	$2b$12$lSOWPyInYs43IK89KLLmQ.KYrdSEIK.QeS5quOd5x0KfOncU4.kHm	2024-10-17 19:32:24	2024-10-17 19:32:24	\N	{}	manager
26	testeur9	test9.login@example.com	$2b$12$1Sh3uhGHRtrM7.2afVdI9OPAn8LWhUiaCC7OVY45hbdLT8kOPzbo.	2024-10-17 19:34:56	2024-10-17 19:34:56	\N	{}	employee
27	testeur9	test9.login@example.com	$2b$12$aOWavg00AADdZ7kLzuzhJO.i.sNYl4NOjWSas2nR4jruhGavv4Mm2	2024-10-17 19:36:15	2024-10-17 19:36:15	\N	{}	user
28	testeur9	test9.login@example.com	$2b$12$C3raI.RRuecVc3XwWcH28ObwOc26mBVdLbuJjyLM4IGVLsBJQM.96	2024-10-17 19:37:40	2024-10-17 19:37:40	\N	{}	super manager
29	testeur10	test10.login@example.com	$2b$12$bA7gYxKjBndZVh4aVwDrn.mB2CHfHCNBYcRyasB3lG71r.y7iOfEa	2024-10-17 19:53:41	2024-10-17 19:53:41	\N	{}	manager
30	testeur10	test10.login@example.com	$2b$12$ybX4bLdGpPrw7XP/eOiwveFGES/vcd4Qqhu2RHXJlZygysq3j8RBO	2024-10-17 19:55:42	2024-10-17 19:55:42	\N	{}	employee
31	testeur10	test10.login@example.com	$2b$12$./0Eg8BDnfdrTQ3ShTaSk.oNIrBN33N0RLJMGEVLRAOW4KcNLPrni	2024-10-17 19:56:31	2024-10-17 19:56:31	\N	{}	user
32	testeur10	test10.login@example.com	$2b$12$EK.JR33ON8pwlnOgLnaECejlz.I.I/bZaxJaT7hiSbLo7DvXk8D7e	2024-10-17 19:57:17	2024-10-17 19:57:17	\N	{}	super manager
33	testeur10	test10.login@example.com	$2b$12$asBnNfS8tO/yfoJJHx5IB.20.EkqgEiiVqoJ2YQimClfc5c7HlII2	2024-10-17 19:57:46	2024-10-17 19:57:46	\N	{}	manager
34	testeur10	test10.login@example.com	$2b$12$K/6jmdeQNRRq77LJhgVLMu0J2S7MNqoR9JiMyFD58nYNzKutaq1k.	2024-10-17 19:58:12	2024-10-17 19:58:12	\N	{}	employee
35	testeur10	test10.login@example.com	$2b$12$/4MiSDnyfYKnVmqb29bHP.u6U3zKXfex7Geo/hH.GkArzpThqsUce	2024-10-17 20:02:49	2024-10-17 20:02:49	\N	{}	user
36	testeur11	test11.login@example.com	$2b$12$gvvoUXaybvffc3xj1InkGOlsk3ei3eB//PpC39NrT1LWVMo0rIssK	2024-10-17 20:09:06	2024-10-17 20:09:06	\N	{}	super manager
37	testeur11	test11.login@example.com	$2b$12$S/D2.SipTjHi5OdSB9R//ebNzrf5apqdIvy.MO6swvUu5bplAzqmK	2024-10-17 20:10:04	2024-10-17 20:10:04	\N	{}	manager
38	testeur11	test11.login@example.com	$2b$12$lhq8bEb3ja.BRJLqxmXqAOdK8QNPu9X8.O0TWTLqa94yYeq0XsNkK	2024-10-17 20:10:39	2024-10-17 20:10:39	\N	{}	employee
39	testeur12	test12.login@example.com	$2b$12$Bd0ztBm4Xe09okgLc3f0WOZFe8CYVx0Kf9kGc4uFRhrk3EsWF9jLm	2024-10-17 20:15:08	2024-10-17 20:15:08	\N	{}	user
40	testeur13	test13.login@example.com	$2b$12$scGWdDhaIcnPwtFTM.9iwuKRcDokhYMbX2XNYF04iEQWhoWmSjulO	2024-10-17 20:18:56	2024-10-17 20:18:56	\N	{}	super manager
41	testeur14	test14.login@example.com	$2b$12$KMpo55HGCSabkxczO5bQDOSP7h8s9IjWa1FwEGNzwx//gyvjmGEP2	2024-10-17 20:20:44	2024-10-17 20:20:44	\N	{}	manager
42	testeur15	test15.login@example.com	$2b$12$vwsgSmUGg5SaFHgbTMTOKeov/eGJOUqpH.FuMtoyqOUoppUt6WoVe	2024-10-17 20:41:40	2024-10-17 20:41:40	\N	{}	employee
43	testeur16	test16.login@example.com	$2b$12$jeBipy.0B6fiKGjqMg6TceRWpeMqiFZC.jCgkRV.ipY8vH1D9nupC	2024-10-17 20:46:45	2024-10-17 20:46:45	\N	{}	user
44	testeur17	test17.login@example.com	$2b$12$hffp7jEkL7KS189rO/cSK.FDCW5McctghPuZgniWyxUuirvncWO6G	2024-10-18 07:47:20	2024-10-18 07:47:20	\N	{}	super manager
45	testeur17	test17.login@example.com	$2b$12$CaDtEStXTeuAxRGg06MydOyprTAyfJVf628A524g7FgJe0L4jbqLi	2024-10-18 10:47:08	2024-10-18 10:47:08	\N	{}	manager
46	testeur17	test17.login@example.com	$2b$12$d.1AqBFH.wu65xzIrIRSG.SZWc5i.Vs27Pg06wUDFHvbCCTJw.gG.	2024-10-18 10:54:32	2024-10-18 10:54:32	\N	{}	employee
47	testeur17	test17.login@example.com	$2b$12$cgxoVj.y/U/.ri4AXgoJ0Ofas8/niVoSMSldGxJiR5i.4UV.jig06	2024-10-18 13:10:02	2024-10-18 13:10:02	\N	{}	user
48	bassem	laradiodebassem@exemple.com	$2b$12$FMOj37ODxX6MeIKyEeirTON5I.wzxq8RlZnqwl1JPQYb3Ykkfh05q	2024-10-18 13:10:10	2024-10-18 13:10:10	\N	{}	super manager
49	testeur17	test17.loginexample.com	$2b$12$sNx3rXpzouhQRGs1Q9gaauvq.e9.D5W2yhmMyQN4eMw.DfdxNNrCG	2024-10-18 13:11:00	2024-10-18 13:11:00	\N	{}	manager
50	tester	tester.cookie@test.com	$2b$12$3jpOK2IIvJtGZq7odiCp3.foF0ko8nQgSAX9Te5SlJlOuA3rYHYMG	2024-10-18 13:12:58	2024-10-18 13:12:58	\N	{}	employee
\.


--
-- Data for Name: workingtime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workingtime (id, start, "end", user_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Name: clock_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clock_periods_id_seq', 2, true);


--
-- Name: clocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clocks_id_seq', 1, false);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 55, true);


--
-- Name: workingtime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workingtime_id_seq', 1, false);


--
-- Name: clock_periods clock_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clock_periods
    ADD CONSTRAINT clock_periods_pkey PRIMARY KEY (id);


--
-- Name: clocks clocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clocks
    ADD CONSTRAINT clocks_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workingtime workingtime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workingtime
    ADD CONSTRAINT workingtime_pkey PRIMARY KEY (id);


--
-- Name: clock_periods_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clock_periods_user_id_index ON public.clock_periods USING btree (user_id);


--
-- Name: clocks_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clocks_user_id_index ON public.clocks USING btree (user_id);


--
-- Name: workingtime_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workingtime_user_id_index ON public.workingtime USING btree (user_id);


--
-- Name: clocks clocks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clocks
    ADD CONSTRAINT clocks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users users_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id);


--
-- Name: workingtime workingtime_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workingtime
    ADD CONSTRAINT workingtime_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

