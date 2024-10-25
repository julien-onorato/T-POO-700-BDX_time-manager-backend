--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clock_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clock_periods (
    id bigint NOT NULL,
    clock_in timestamp(0) without time zone,
    clock_out timestamp(0) without time zone,
    user_id bigint,
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


ALTER TABLE public.clock_periods_id_seq OWNER TO postgres;

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


ALTER TABLE public.clocks_id_seq OWNER TO postgres;

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
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255),
    email character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
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


ALTER TABLE public.users_id_seq OWNER TO postgres;

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


ALTER TABLE public.workingtime_id_seq OWNER TO postgres;

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
1	2024-10-10 09:00:00	\N	8	2024-10-10 09:25:04	2024-10-10 09:25:04
2	2024-10-10 09:00:00	\N	8	2024-10-10 09:57:27	2024-10-10 09:57:27
3	2024-10-10 09:00:00	\N	8	2024-10-10 09:58:18	2024-10-10 09:58:18
4	2050-10-10 09:00:00	\N	8	2024-10-10 10:04:46	2024-10-10 10:04:46
5	2050-10-10 09:00:00	\N	8	2024-10-10 10:13:13	2024-10-10 10:13:13
6	2055-10-10 09:00:00	2024-10-10 10:18:38	8	2024-10-10 10:18:31	2024-10-10 10:18:38
7	2055-10-10 09:00:00	2024-10-10 10:23:52	8	2024-10-10 10:23:46	2024-10-10 10:23:52
8	2055-10-10 09:00:00	2024-10-10 10:25:04	8	2024-10-10 10:25:00	2024-10-10 10:25:04
9	2024-10-10 10:34:46	\N	8	2024-10-10 10:34:48	2024-10-10 10:34:48
10	2024-10-10 10:35:09	\N	8	2024-10-10 10:35:11	2024-10-10 10:35:11
11	2024-10-10 10:35:30	\N	8	2024-10-10 10:35:32	2024-10-10 10:35:32
12	2024-10-10 10:36:30	2024-10-10 10:36:41	8	2024-10-10 10:36:31	2024-10-10 10:36:41
13	2024-10-10 10:36:52	2024-10-10 10:37:08	8	2024-10-10 10:36:53	2024-10-10 10:37:08
14	2024-10-10 10:37:20	2024-10-10 10:40:52	8	2024-10-10 10:37:22	2024-10-10 10:40:52
15	2024-10-10 10:40:55	2024-10-10 10:41:58	8	2024-10-10 10:40:56	2024-10-10 10:41:58
16	2024-10-10 10:42:16	2024-10-10 10:44:26	8	2024-10-10 10:42:18	2024-10-10 10:44:26
17	2024-10-10 10:44:53	2024-10-10 10:45:48	8	2024-10-10 10:44:54	2024-10-10 10:45:48
18	2055-10-10 09:00:00	2024-10-10 10:50:29	8	2024-10-10 10:49:46	2024-10-10 10:50:29
19	2024-10-10 10:50:31	2024-10-10 10:50:43	8	2024-10-10 10:50:33	2024-10-10 10:50:43
20	2024-10-10 10:51:34	2024-10-10 10:51:56	8	2024-10-10 10:51:36	2024-10-10 10:51:56
21	2024-10-10 12:07:55	\N	8	2024-10-10 12:08:10	2024-10-10 12:08:10
22	2024-10-10 12:08:40	2024-10-10 12:08:50	8	2024-10-10 12:08:43	2024-10-10 12:08:50
23	2024-10-10 12:51:12	2024-10-10 12:51:35	8	2024-10-10 12:51:16	2024-10-10 12:51:35
24	2024-10-10 13:04:24	\N	8	2024-10-10 13:04:26	2024-10-10 13:04:26
25	2024-10-10 13:12:43	\N	8	2024-10-10 13:12:45	2024-10-10 13:12:45
26	2024-10-10 13:14:01	\N	8	2024-10-10 13:14:02	2024-10-10 13:14:02
27	2024-10-10 13:15:01	2024-10-10 13:15:48	8	2024-10-10 13:15:03	2024-10-10 13:15:48
28	2024-10-10 13:17:41	\N	8	2024-10-10 13:17:43	2024-10-10 13:17:43
29	2024-10-10 13:18:39	2024-10-10 13:18:45	8	2024-10-10 13:18:41	2024-10-10 13:18:45
30	2024-10-10 13:21:38	2024-10-10 13:21:44	8	2024-10-10 13:21:39	2024-10-10 13:21:44
31	2024-10-10 13:26:01	2024-10-10 13:28:07	8	2024-10-10 13:26:03	2024-10-10 13:28:07
32	2024-10-10 13:33:00	2024-10-10 13:33:13	8	2024-10-10 13:33:02	2024-10-10 13:33:13
33	2024-10-10 13:38:44	2024-10-10 13:38:58	8	2024-10-10 13:38:48	2024-10-10 13:38:58
34	2024-10-10 13:43:30	2024-10-10 13:43:38	8	2024-10-10 13:43:33	2024-10-10 13:43:38
35	2024-10-10 14:43:33	2024-10-10 14:43:41	8	2024-10-10 14:43:37	2024-10-10 14:43:41
36	2024-10-11 07:54:55	2024-10-11 07:55:07	8	2024-10-11 07:54:59	2024-10-11 07:55:07
\.


--
-- Data for Name: clocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clocks (id, "time", status, user_id, inserted_at, updated_at) FROM stdin;
1	2024-10-08 14:30:00	t	2	2024-10-08 16:57:36	2024-10-08 16:57:36
2	2024-10-08 14:30:00	t	2	2024-10-08 16:59:22	2024-10-08 16:59:22
3	2024-10-08 14:30:00	t	2	2024-10-08 17:01:24	2024-10-08 17:01:24
4	2024-10-08 14:30:00	t	2	2024-10-08 17:02:44	2024-10-08 17:02:44
5	2024-10-08 14:30:00	t	3	2024-10-08 17:18:09	2024-10-08 17:18:09
6	2028-11-08 14:30:00	t	3	2024-10-09 12:29:37	2024-10-09 12:29:37
7	2028-11-08 14:30:00	t	2	2024-10-09 13:11:01	2024-10-09 13:11:01
8	2060-11-08 14:30:00	t	2	2024-10-09 13:16:12	2024-10-09 13:16:12
9	2060-11-08 14:30:00	t	2	2024-10-09 13:23:28	2024-10-09 13:23:28
10	2024-10-09 13:25:46	t	2	2024-10-09 13:25:53	2024-10-09 13:25:53
11	2024-10-09 13:28:46	t	2	2024-10-09 13:28:48	2024-10-09 13:28:48
12	2024-10-09 13:32:39	t	2	2024-10-09 13:32:41	2024-10-09 13:32:41
13	2024-10-09 13:34:59	t	2	2024-10-09 13:35:00	2024-10-09 13:35:00
14	2024-10-09 13:35:06	t	2	2024-10-09 13:35:08	2024-10-09 13:35:08
15	2024-10-09 13:55:27	t	2	2024-10-09 13:55:33	2024-10-09 13:55:33
16	2024-10-09 14:43:40	t	2	2024-10-09 14:43:42	2024-10-09 14:43:42
17	2024-10-09 14:47:09	t	2	2024-10-09 14:47:11	2024-10-09 14:47:11
18	2024-10-09 14:56:26	t	2	2024-10-09 14:56:28	2024-10-09 14:56:28
19	2024-10-09 14:57:11	t	2	2024-10-09 14:57:13	2024-10-09 14:57:13
20	2024-10-09 15:10:46	t	2	2024-10-09 15:10:48	2024-10-09 15:10:48
21	2024-10-09 15:14:41	t	2	2024-10-09 15:14:44	2024-10-09 15:14:44
22	2060-11-08 14:30:00	t	2	2024-10-09 15:16:33	2024-10-09 15:16:33
23	2024-10-09 15:19:03	t	2	2024-10-09 15:19:05	2024-10-09 15:19:05
24	2024-10-10 07:47:24	t	2	2024-10-10 07:47:29	2024-10-10 07:47:29
25	2024-10-10 07:47:27	t	2	2024-10-10 07:47:30	2024-10-10 07:47:30
26	2024-10-10 08:04:36	t	2	2024-10-10 08:04:42	2024-10-10 08:04:42
27	2024-10-10 08:09:37	f	2	2024-10-10 08:09:25	2024-10-10 08:09:37
28	2024-10-10 08:12:44	f	2	2024-10-10 08:12:28	2024-10-10 08:12:44
29	2024-10-10 08:13:36	f	2	2024-10-10 08:13:19	2024-10-10 08:13:36
30	2024-10-10 08:14:10	f	2	2024-10-10 08:13:44	2024-10-10 08:14:10
31	2024-10-10 08:14:45	f	2	2024-10-10 08:14:37	2024-10-10 08:14:45
32	2024-10-10 08:15:40	t	2	2024-10-10 08:15:41	2024-10-10 08:15:41
33	2024-10-10 08:17:57	f	2	2024-10-10 08:17:52	2024-10-10 08:17:57
34	2024-10-10 08:18:21	f	2	2024-10-10 08:18:08	2024-10-10 08:18:21
35	2024-10-10 08:18:56	f	2	2024-10-10 08:18:43	2024-10-10 08:18:56
36	2024-10-10 08:21:02	f	2	2024-10-10 08:20:57	2024-10-10 08:21:02
37	2024-10-10 08:21:45	f	3	2024-10-10 08:21:40	2024-10-10 08:21:45
38	2024-10-10 08:22:02	f	3	2024-10-10 08:21:57	2024-10-10 08:22:02
39	2024-10-10 08:25:39	f	3	2024-10-10 08:25:34	2024-10-10 08:25:39
40	2024-10-10 08:27:47	f	3	2024-10-10 08:27:41	2024-10-10 08:27:47
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20241007133418	2024-10-08 08:27:24
20241007133433	2024-10-08 08:27:24
20241007133445	2024-10-08 08:27:24
20241010084443	2024-10-10 08:45:40
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, inserted_at, updated_at) FROM stdin;
2	test1	test1@example.com	2024-10-08 08:37:04	2024-10-08 08:37:04
3	test1	test1@example.com	2024-10-08 08:39:42	2024-10-08 08:39:42
4	test1	test1@example.com	2024-10-08 08:43:17	2024-10-08 08:43:17
5	john_doe	john.doe@example.com	2024-10-08 17:23:51	2024-10-08 17:23:51
6	john_doe	john.doe@example.com	2024-10-08 17:25:13	2024-10-08 17:25:13
7	john_doe	john.doe@example.com	2024-10-08 17:27:03	2024-10-08 17:27:03
8	john_doe	john.doe@example.com	2024-10-08 17:29:20	2024-10-08 17:29:20
\.


--
-- Data for Name: workingtime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workingtime (id, start, "end", user_id, inserted_at, updated_at) FROM stdin;
2	2022-10-08 14:30:00	2026-10-08 14:30:00	8	2024-10-08 17:46:43	2024-10-08 17:46:43
4	2025-10-08 14:30:00	2030-10-08 14:30:00	8	2024-10-08 17:56:49	2024-10-08 17:56:49
5	2030-10-08 14:30:00	2035-10-08 14:30:00	8	2024-10-08 17:58:31	2024-10-08 17:58:31
6	2030-10-08 14:30:00	2035-10-08 14:30:00	8	2024-10-08 18:06:14	2024-10-08 18:06:14
1	2030-10-08 14:30:00	2045-10-08 14:30:00	8	2024-10-08 17:43:19	2024-10-08 18:18:04
7	2030-10-08 14:30:00	2045-10-08 14:30:00	2	2024-10-09 14:31:41	2024-10-09 14:31:41
8	2030-10-08 14:30:00	2045-10-08 14:30:00	2	2024-10-09 14:33:24	2024-10-09 14:33:24
\.


--
-- Name: clock_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clock_periods_id_seq', 36, true);


--
-- Name: clocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clocks_id_seq', 40, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: workingtime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workingtime_id_seq', 8, true);


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
-- Name: clock_periods clock_periods_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clock_periods
    ADD CONSTRAINT clock_periods_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: clocks clocks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clocks
    ADD CONSTRAINT clocks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: workingtime workingtime_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workingtime
    ADD CONSTRAINT workingtime_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

