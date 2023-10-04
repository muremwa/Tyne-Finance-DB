# Auto generated

create table auth_group
(
    id   int auto_increment
        primary key,
    name varchar(150) not null,
    constraint name
        unique (name)
);

create table core_accounttype
(
    id   bigint auto_increment
        primary key,
    name varchar(100) not null,
    code varchar(20)  not null,
    constraint code
        unique (code)
);

create table core_currency
(
    id      bigint auto_increment
        primary key,
    country varchar(100) not null,
    code    varchar(10)  not null,
    symbol  varchar(10)  null,
    constraint core_currency_country_code_0fa40af9_uniq
        unique (country, code)
);

create table core_user
(
    id           bigint auto_increment
        primary key,
    password     varchar(128) not null,
    last_login   datetime(6)  null,
    is_superuser tinyint(1)   not null,
    username     varchar(150) not null,
    first_name   varchar(150) not null,
    last_name    varchar(150) not null,
    email        varchar(254) not null,
    is_staff     tinyint(1)   not null,
    is_active    tinyint(1)   not null,
    date_joined  datetime(6)  not null,
    currency_id  bigint       null,
    constraint username
        unique (username),
    constraint core_user_currency_id_6df45346_fk_core_currency_id
        foreign key (currency_id) references core_currency (id)
);

create table authtoken_token
(
    `key`   varchar(40) not null
        primary key,
    created datetime(6) not null,
    user_id bigint      not null,
    constraint user_id
        unique (user_id),
    constraint authtoken_token_user_id_35299eff_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table budgets_budgetitem
(
    id            bigint auto_increment
        primary key,
    start_date    date        not null,
    end_date      date        not null,
    name          varchar(50) not null,
    narration     longtext    not null,
    amount        int         not null,
    date_added    datetime(6) not null,
    date_modified datetime(6) not null,
    user_id       bigint      not null,
    constraint budgets_budgetitem_user_id_7c0f691e_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table budgets_wishlistitem
(
    id            bigint auto_increment
        primary key,
    name          varchar(50) not null,
    narration     longtext    not null,
    price         int         not null,
    due_date      date        not null,
    date_added    datetime(6) not null,
    date_modified datetime(6) not null,
    user_id       bigint      not null,
    granted       tinyint(1)  not null,
    constraint budgets_wishlistitem_user_id_7c1b52c2_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table core_account
(
    id                  bigint auto_increment
        primary key,
    account_provider    varchar(100) not null,
    account_number      varchar(50)  not null,
    date_added          datetime(6)  not null,
    date_modified       datetime(6)  not null,
    balance             int          not null,
    last_balance_update datetime(6)  null,
    active              tinyint(1)   not null,
    account_type_id     bigint       not null,
    user_id             bigint       not null,
    constraint core_account_account_provider_account_d4c024fd_uniq
        unique (account_provider, account_number, account_type_id),
    constraint core_account_account_type_id_dd87dfe2_fk_core_accounttype_id
        foreign key (account_type_id) references core_accounttype (id),
    constraint core_account_user_id_8d2af6ae_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table core_user_groups
(
    id       bigint auto_increment
        primary key,
    user_id  bigint not null,
    group_id int    not null,
    constraint core_user_groups_user_id_group_id_c82fcad1_uniq
        unique (user_id, group_id),
    constraint core_user_groups_group_id_fe8c697f_fk_auth_group_id
        foreign key (group_id) references auth_group (id),
    constraint core_user_groups_user_id_70b4d9b8_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table auth_permission
(
    id              int auto_increment
        primary key,
    name            varchar(255) not null,
    content_type_id int          not null,
    codename        varchar(100) not null,
    constraint auth_permission_content_type_id_codename_01ab375a_uniq
        unique (content_type_id, codename)
);

create table auth_group_permissions
(
    id            bigint auto_increment
        primary key,
    group_id      int not null,
    permission_id int not null,
    constraint auth_group_permissions_group_id_permission_id_0cd325b0_uniq
        unique (group_id, permission_id),
    constraint auth_group_permissio_permission_id_84c5c92e_fk_auth_perm
        foreign key (permission_id) references auth_permission (id),
    constraint auth_group_permissions_group_id_b120cbf9_fk_auth_group_id
        foreign key (group_id) references auth_group (id)
);

create table core_user_user_permissions
(
    id            bigint auto_increment
        primary key,
    user_id       bigint not null,
    permission_id int    not null,
    constraint core_user_user_permissions_user_id_permission_id_73ea0daa_uniq
        unique (user_id, permission_id),
    constraint core_user_user_permi_permission_id_35ccf601_fk_auth_perm
        foreign key (permission_id) references auth_permission (id),
    constraint core_user_user_permissions_user_id_085123d3_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table expenses_expense
(
    id                 bigint auto_increment
        primary key,
    planned            tinyint(1)        not null,
    narration          longtext          not null,
    amount             int               not null,
    transaction_charge int               not null,
    date_created       datetime(6)       not null,
    date_occurred      date              not null,
    user_id            bigint default -1 not null,
    constraint expenses_expense_user_id_to_core_user_id
        foreign key (user_id) references core_user (id)
);

create table expenses_recurringpayment
(
    id                 bigint auto_increment
        primary key,
    narration          longtext    not null,
    amount             int         not null,
    transaction_charge int         not null,
    start_date         date        not null,
    end_date           date        null,
    renewal_date       varchar(5)  not null,
    date_added         datetime(6) not null,
    date_modified      datetime(6) not null,
    renewal_count      int         not null,
    user_id            bigint      not null,
    constraint expenses_recurringpayment_user_id_62ffa16d_fk_core_user_id
        foreign key (user_id) references core_user (id)
);

create table expenses_transaction
(
    id                 bigint auto_increment
        primary key,
    transaction_type   enum ('DB', 'CD') not null,
    amount             int               not null,
    automatic          tinyint(1)        not null,
    transaction_date   datetime(6)       not null,
    transaction_for    enum ('EX', 'RP') not null,
    transaction_for_id int               null,
    account_id         bigint            not null,
    constraint expenses_transaction_account_id_95203b9e_fk_core_account_id
        foreign key (account_id) references core_account (id)
);

create table expenses_usagetag
(
    id    bigint auto_increment
        primary key,
    title varchar(100) not null,
    code  varchar(10)  not null,
    constraint code
        unique (code)
);

create table budgets_budgetitem_tags
(
    id            bigint auto_increment
        primary key,
    budgetitem_id bigint not null,
    usagetag_id   bigint not null,
    constraint budgets_budgetitem_tags_budgetitem_id_usagetag_id_fdecee74_uniq
        unique (budgetitem_id, usagetag_id),
    constraint budgets_budgetitem_t_budgetitem_id_7d3950f8_fk_budgets_b
        foreign key (budgetitem_id) references budgets_budgetitem (id),
    constraint budgets_budgetitem_t_usagetag_id_e4b7619e_fk_expenses_
        foreign key (usagetag_id) references expenses_usagetag (id)
);

create table expenses_expense_tags
(
    id          bigint auto_increment
        primary key,
    expense_id  bigint not null,
    usagetag_id bigint not null,
    constraint expenses_expense_tags_expense_id_usagetag_id_1458bbcc_uniq
        unique (expense_id, usagetag_id),
    constraint expenses_expense_tag_usagetag_id_fed72b0d_fk_expenses_
        foreign key (usagetag_id) references expenses_usagetag (id),
    constraint expenses_expense_tags_expense_id_a477836f_fk_expenses_expense_id
        foreign key (expense_id) references expenses_expense (id)
);

create table expenses_recurringpayment_tags
(
    id                  bigint auto_increment
        primary key,
    recurringpayment_id bigint not null,
    usagetag_id         bigint not null,
    constraint expenses_recurringpaymen_recurringpayment_id_usag_dd14b69d_uniq
        unique (recurringpayment_id, usagetag_id),
    constraint expenses_recurringpa_recurringpayment_id_8e9c211f_fk_expenses_
        foreign key (recurringpayment_id) references expenses_recurringpayment (id),
    constraint expenses_recurringpa_usagetag_id_7f5b2fd3_fk_expenses_
        foreign key (usagetag_id) references expenses_usagetag (id)
);


